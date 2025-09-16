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

    // Prepare login form data
    Map<String, String> formData = {
      'username': event.userData,
      'password': event.password,
    };

    AppUtils().debuglog(formData);
    AppRepository appRepository = AppRepository();

    try {
      final loginResponse = await appRepository.postRequest(
        formData,
        AppApis.http + event.schoolId + AppApis.loginStudent,
      );

      AppUtils().debuglog('Response status: ${loginResponse.statusCode}');
      AppUtils().debuglog('Response body: ${loginResponse.body}');
      AppUtils().debuglog('Response headers: ${loginResponse.headers}');

      if (loginResponse.statusCode == 200 || loginResponse.statusCode == 201) {
        final responseJson = json.decode(loginResponse.body);

        // Parse school
        SchoolModel schoolModel =
        SchoolModel.fromJson(responseJson['school'][0]);

        // Save schoolId, tokens
        await SharedPref.putString(
            SharedPreferenceKey().schoolIdKey, event.schoolId);
        await SharedPref.putString(
            SharedPreferenceKey().accessTokenKey, responseJson['access']);
        await SharedPref.putString(
            SharedPreferenceKey().refreshTokenKey, responseJson['refresh']);

        // Save sessionid + csrftoken from headers (cookies)
        if (loginResponse.headers['set-cookie'] != null) {
          String rawCookies = loginResponse.headers['set-cookie']!;
          List<String> cookieList = rawCookies.split(',');
          for (var cookie in cookieList) {
            if (cookie.contains("sessionid")) {
              String sessionId = cookie.split(";").first.split("=").last;
              await SharedPref.putString(
                  SharedPreferenceKey().sessionIdKey, sessionId);
            }
            if (cookie.contains("csrftoken")) {
              String csrf = cookie.split(";").first.split("=").last;
              await SharedPref.putString(
                  SharedPreferenceKey().csrftokenKey, csrf);
            }
          }
        }

        // Fetch dashboard
        final studentDashboardResponse =
        await appRepository.getRequestWithToken(
          responseJson['access'],
          AppApis.http + event.schoolId + AppApis.dashboard,
        );

        AppUtils().debuglog(
            'Dashboard status: ${studentDashboardResponse.statusCode}');

        if (studentDashboardResponse.statusCode == 200 ||
            studentDashboardResponse.statusCode == 201) {
          final dashboardJson = json.decode(studentDashboardResponse.body);

          StudentProfile studentProfile =
          StudentProfile.fromJson(dashboardJson['current_data']['student']);
          ClassModel classModel = ClassModel.fromJson(
              dashboardJson['current_data']['current_class']);
          SessionModel sessionModel =
          SessionModel.fromJson(dashboardJson['current_data']['session']);

          List<Subject> subjectList = (dashboardJson['subjects'] as List)
              .map((item) => Subject.fromJson(item))
              .toList();

          // Fetch results archive (sessions)
          final sessionResponse = await appRepository.getRequestWithToken(
            responseJson['access'],
            '${AppApis.http}${event.schoolId}${AppApis.resultsArchive}',
          );

          List<SessionModel> sessionsList = [];
          if (sessionResponse.statusCode == 200) {
            final sessionsJson = json.decode(sessionResponse.body)['sessions'];
            sessionsList =
                (sessionsJson as List).map((e) => SessionModel.fromJson(e)).toList();
          }

          emit(SuccessState("Login Successful", studentProfile, schoolModel,
              subjectList, sessionModel, classModel, sessionsList));
        } else if (studentDashboardResponse.statusCode == 401) {
          emit(AccessTokenExpireState());
        } else {
          emit(ErrorState(
              json.decode(studentDashboardResponse.body)['detail'] ??
                  "Dashboard error"));
          emit(AuthInitial());
        }
      } else if (loginResponse.statusCode == 500 ||
          loginResponse.statusCode == 501) {
        emit(ErrorState(
            "There was a problem logging user in please try again later."));
        emit(AuthInitial());
      } else {
        emit(ErrorState(json.decode(loginResponse.body)['error'] ??
            "Unknown login error"));
        emit(AuthInitial());
      }
    } catch (e) {
      AppUtils().debuglog(e.toString());
      emit(ErrorState("There was a problem logging you in. Please try again."));
      emit(AuthInitial());
    }
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
