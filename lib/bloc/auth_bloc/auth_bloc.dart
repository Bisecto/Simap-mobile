import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'package:simap/model/class_model.dart';
import 'package:simap/model/school_model.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/res/shared_preferenceKey.dart';
import 'package:simap/utills/shared_preferences.dart';

import '../../app_repository/repository.dart';
import '../../model/student_profile.dart';
import '../../model/subject.dart';
import '../../res/apis.dart';
import '../../res/tem_data/tem_data.dart';
import '../../utills/app_utils.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEventClick>(signInEventClick);
    // on<OnVerifyDeviceEvent>(onVerifyDeviceEvent);
    on<InitialEvent>(initialEvent);
    on<RequestResetPasswordEventClick>(requestResetPasswordEventClick);
    on<OnVerifyOtpEvent>(onVerifyOtpEvent);
    on<ResetPasswordEventClick>(resetPasswordEventClick);
  }

  Future<FutureOr<void>> signInEventClick(
      SignInEventClick event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    Map<String, String> formData = {
      'username': event.userData,
      'password': event.password,
    };
    AppUtils().debuglog(formData);
    AppRepository appRepository = AppRepository();

    print(AppApis.http + event.schoolId + AppApis.loginStudent);
    //try {
    final loginResponse = await appRepository.postRequest(
        formData, AppApis.http + event.schoolId + AppApis.loginStudent);

    AppUtils().debuglog('Response status: ${loginResponse.statusCode}');
    AppUtils().debuglog('Response body: ${loginResponse.body}');
    AppUtils().debuglog(loginResponse.statusCode);

    AppUtils().debuglog(loginResponse.body);
    AppUtils().debuglog("loginResponse.body");
    AppUtils().debuglog(loginResponse.headers);

    if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
      SchoolModel schoolModel =
          SchoolModel.fromJson(json.decode(loginResponse.body)['school'][0]);

      await SharedPref.putString(
          SharedPreferenceKey().schoolIdKey, event.schoolId);
      await SharedPref.putString(SharedPreferenceKey().accessTokenKey,
          json.decode(loginResponse.body)['access']);
      await SharedPref.putString(SharedPreferenceKey().refreshTokenKey,
          json.decode(loginResponse.body)['refresh']);

      final studentDashboardResponse = await appRepository.getRequestWithToken(
        json.decode(loginResponse.body)['access'],
        AppApis.http + event.schoolId + AppApis.dashboard,
      );

      AppUtils()
          .debuglog('se status: ${json.decode(loginResponse.body)['access']}');
      AppUtils().debuglog(
          'Dashboard Response status: ${studentDashboardResponse.statusCode}');
      //AppUtils().debuglog('Dashboard Response body: ${studentDashboardResponse.body}');

      if (studentDashboardResponse.statusCode == 200 ||
          studentDashboardResponse.statusCode == 201) {
        //AppUtils().debuglog(studentDashboardResponse.body);
        StudentProfile studentProfile = StudentProfile.fromJson(json
            .decode(studentDashboardResponse.body)['current_data']['student']);
        ClassModel classModel = ClassModel.fromJson(
            json.decode(studentDashboardResponse.body)['current_data']
                ['current_class']);
        CurrentSessionModel sessionModel = CurrentSessionModel.fromJson(json
            .decode(studentDashboardResponse.body)['current_data']['session']);

        AppUtils().debuglog(studentProfile);
        AppUtils().debuglog(studentProfile);
        List<dynamic> subjectJsonResponse =
            json.decode(studentDashboardResponse.body)['subjects'];

        List<Subject> subjectList =
            subjectJsonResponse.map((item) => Subject.fromJson(item)).toList();

        emit(SuccessState("Login Successful", studentProfile, schoolModel,
            subjectList, sessionModel,classModel));
      } else if (studentDashboardResponse.statusCode == 401) {
        emit(AccessTokenExpireState());
      } else {
        emit(ErrorState(json.decode(loginResponse.body)['detail']));
        //AppUtils().debuglog(json.decode(loginResponse.body));
        emit(AuthInitial());
      }
    } else if (loginResponse.statusCode == 500 ||
        loginResponse.statusCode == 501) {
      emit(ErrorState(
          "There was a problem logging user in please try again later."));
      emit(AuthInitial());
    } else {
      emit(ErrorState(json.decode(loginResponse.body)['error']));
      //AppUtils().debuglog(event.password);
      AppUtils().debuglog(json.decode(loginResponse.body));
      emit(AuthInitial());
    }
    // } catch (e) {
    //   AppUtils().debuglog(e);
    //   emit(ErrorState("There was a problem login you in please try again."));
    //
    //   AppUtils().debuglog(e);
    //   emit(AuthInitial());
    //   AppUtils().debuglog(12345678);
    // }
  }

  FutureOr<void> initialEvent(InitialEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }

  Future<FutureOr<void>> requestResetPasswordEventClick(
      RequestResetPasswordEventClick event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    // AppRepository AppRepository = AppRepository();
    // Map<String, String> formData = {
    //   'email': event.userData,
    // };
    AppUtils().debuglog(event.userData);
    String deviceId = await AppUtils.getId();

    try {
      // final response = await AppRepository.authPostRequest(
      //     formData, AppApis.requestPasswordResetOtp)
      AppUtils().debuglog(
          Uri.parse('${AppApis.appBaseUrl}/u-auth/request-password-reset/'));
      AppUtils().debuglog({'email': event.userData});
      var resetResponse = await http.post(
        Uri.parse('${AppApis.appBaseUrl}/u-auth/request-password-reset/'),
        body: {'email': event.userData},
      );

      AppUtils().debuglog('Response status: ${resetResponse.statusCode}');
      AppUtils().debuglog('Response body: ${resetResponse.body}');
      AppUtils().debuglog(resetResponse.statusCode);

      AppUtils().debuglog(resetResponse.body);
      if (resetResponse.statusCode == 200) {
        emit(OtpRequestSuccessState(
            json.decode(resetResponse.body)['message'], event.userData));
      } else if (resetResponse.statusCode == 500 ||
          resetResponse.statusCode == 501) {
        emit(ErrorState("Error Occurred please try again later."));
        emit(AuthInitial());
      } else {
        emit(ErrorState(json.decode(resetResponse.body)['error']));
        //AppUtils().debuglog(event.password);
        AppUtils().debuglog(json.decode(resetResponse.body));
        emit(AuthInitial());
      }
    } catch (e) {
      AppUtils().debuglog(e);
      emit(ErrorState("Error Requesting password reset"));

      emit(AuthInitial());
      AppUtils().debuglog(12345678);
    }
  }

  Future<FutureOr<void>> onVerifyOtpEvent(
      OnVerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    //AppUtils().debuglog(formData);

    try {
      var verifyResponse = await http.post(
        Uri.parse('${AppApis.appBaseUrl}/u-auth/verify-otp/'),
        body: {'email': event.userData, 'otp': event.otp.toString()},
      );
      AppUtils().debuglog('Response status: ${verifyResponse.statusCode}');
      AppUtils().debuglog('Response body: ${verifyResponse.body}');
      AppUtils().debuglog(verifyResponse.statusCode);

      AppUtils().debuglog(verifyResponse.body);

      if (verifyResponse.statusCode == 200) {
        AppUtils().debuglog(json.decode(verifyResponse.body)['access']);

        emit(OtpVerificationSuccessState(
            json.decode(verifyResponse.body)['message']));
      } else if (verifyResponse.statusCode == 500 ||
          verifyResponse.statusCode == 501) {
        emit(ErrorState(
            "There was a problem verifying otp please try again later."));
        emit(AuthInitial());
      } else {
        emit(ErrorState(json.decode(verifyResponse.body)['error']));
        //AppUtils().debuglog(event.password);
        AppUtils().debuglog(json.decode(verifyResponse.body));
        emit(AuthInitial());
      }
    } catch (e) {
      AppUtils().debuglog(e);
      emit(ErrorState("Error Verifying otp"));

      emit(AuthInitial());
      AppUtils().debuglog(12345678);
    }
  }

  Future<FutureOr<void>> resetPasswordEventClick(
      ResetPasswordEventClick event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    AppUtils().debuglog(event.password);
    try {
      var resetPasswordResponse = await http.post(
        Uri.parse('${AppApis.appBaseUrl}/u-auth/reset-password/'),
        headers: {
          'Authorization': 'JWT ',
        },
        body: {'new_password': event.password},
      );

      AppUtils()
          .debuglog('Response status: ${resetPasswordResponse.statusCode}');
      AppUtils().debuglog('Response body: ${resetPasswordResponse.body}');
      AppUtils().debuglog(resetPasswordResponse.statusCode);

      AppUtils().debuglog(resetPasswordResponse.body);

      if (resetPasswordResponse.statusCode == 200) {
        AppUtils().debuglog(resetPasswordResponse.body);
        // await SharedPref.putString(
        //     "refresh-token", json.decode(response.body)['refresh']);

        emit(ResetPasswordSuccessState(
            json.decode(resetPasswordResponse.body)['success']));
      } else if (resetPasswordResponse.statusCode == 401) {
        emit(AccessTokenExpireState());
      } else if (resetPasswordResponse.statusCode == 500 ||
          resetPasswordResponse.statusCode == 501) {
        emit(ErrorState(
            "There was a problem resting password please try again later."));
        emit(AuthInitial());
      } else {
        emit(ErrorState(json.decode(resetPasswordResponse.body)['detail']));
        //AppUtils().debuglog(event.password);
        AppUtils().debuglog(json.decode(resetPasswordResponse.body));
        emit(AuthInitial());
      }
    } catch (e) {
      AppUtils().debuglog(e);
      emit(ErrorState("Error Resetting password"));

      emit(AuthInitial());
      AppUtils().debuglog(12345678);
    }
  }
}
