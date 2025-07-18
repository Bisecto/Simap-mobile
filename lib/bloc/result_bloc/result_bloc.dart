import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simap/model/session_model.dart';
import 'package:simap/res/shared_preferenceKey.dart';

import '../../app_repository/repository.dart';
import '../../model/result_model/result_model.dart';
import '../../res/apis.dart';
import '../../utills/app_utils.dart';
import '../../utills/shared_preferences.dart';

part 'result_event.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial()) {
    on<FetchSessionResult>(fetchSessionResult);
    on<FetchSession>(fetchSession);
    // on<ResultEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  FutureOr<void> fetchSessionResult(
      FetchSessionResult event, Emitter<ResultState> emit) async {
    emit(LoadingState());
    AppUtils().debuglog(12345);
    AppRepository repository = AppRepository();
    //try {
    String accessToken =
        await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
    String schoolId =
        await SharedPref.getString(SharedPreferenceKey().schoolIdKey);
    // Map<String, String> formData = {
    //   'session_id': event.sessionId,
    //   'semester_id': event.semesterId,
    //   //'otp': event.otp,
    // };
    // final resultRespomse = await repository.getRequestWithToken(accessToken,
    //   AppApis.sessionApi,
    // );
    final resultRespomse = await repository.getRequestWithToken(
        accessToken,
        // formData,
        '${AppApis.http}$schoolId${AppApis.resultsArchive}/${event.sessionId}/${event.session.replaceAll('/', '')}');

    AppUtils().debuglog(resultRespomse.statusCode);
    //AppUtils().debuglog(resultRespomse.body);
    if (resultRespomse.statusCode == 200 || resultRespomse.statusCode == 201) {
      print(json.decode(resultRespomse.body));
      ResultModel resultModel =
          ResultModel.fromJson(jsonDecode(resultRespomse.body));
      emit(InitialSuccessState("Successful", resultModel));
    } else if (resultRespomse.statusCode == 401) {
      emit(AccessTokenExpireState());
    } else if (resultRespomse.statusCode == 500 ||
        resultRespomse.statusCode == 501) {
      emit(ErrorState(
          "There was a problem processing request please try again later."));
      emit(ResultInitial());
    } else {
      emit(ErrorState(json.decode(resultRespomse.body)['detail'] ??
          json.decode(resultRespomse.body)['error']));
      //AppUtils().debuglog(event.password);
      AppUtils().debuglog(json.decode(resultRespomse.body));
      emit(ResultInitial());
    }
    // } catch (e) {
    //   AppUtils().debuglog(e);
    //   emit(ResultInitial());
    //   AppUtils().debuglog(12345678);
    // }
  }

  FutureOr<void> fetchSession(
      FetchSession event, Emitter<ResultState> emit) async {
    emit(LoadingState());
    AppUtils().debuglog(12345);
    AppRepository repository = AppRepository();
    //try {
    String accessToken =
        await SharedPref.getString(SharedPreferenceKey().accessTokenKey);
    String schoolId =
        await SharedPref.getString(SharedPreferenceKey().schoolIdKey);
    // Map<String, String> formData = {
    //   'session_id': event.sessionId,
    //   'semester_id': event.semesterId,
    //   //'otp': event.otp,
    // };
    // final resultRespomse = await repository.getRequestWithToken(accessToken,
    //   AppApis.sessionApi,
    // );
    final sessionRespomse = await repository.getRequestWithToken(
        accessToken,
        // formData,
        '${AppApis.http}$schoolId${AppApis.resultsArchive}');

    AppUtils().debuglog(sessionRespomse.statusCode);
    //AppUtils().debuglog(resultRespomse.body);
    if (sessionRespomse.statusCode == 200 ||
        sessionRespomse.statusCode == 201) {
      print(json.decode(sessionRespomse.body)[0]);
      print(json.decode(sessionRespomse.body)[0]);
      print(json.decode(sessionRespomse.body));
      print(json.decode(sessionRespomse.body));
      print(json.decode(sessionRespomse.body));
      List<dynamic> sessionsJsonResponse = json.decode(sessionRespomse.body)['sessions'];

      List<SessionModel> sessionsList = sessionsJsonResponse
          .map((item) => SessionModel.fromJson(item))
          .toList();
      emit(ArchivedSuccessState("Successful", sessionsList));
    } else if (sessionRespomse.statusCode == 401) {
      emit(AccessTokenExpireState());
    } else if (sessionRespomse.statusCode == 500 ||
        sessionRespomse.statusCode == 501) {
      emit(ErrorState(
          "There was a problem processing request please try again later."));
      emit(ResultInitial());
    } else {
      emit(ErrorState(json.decode(sessionRespomse.body)['detail'] ??
          json.decode(sessionRespomse.body)['error']));
      //AppUtils().debuglog(event.password);
      AppUtils().debuglog(json.decode(sessionRespomse.body));
      emit(ResultInitial());
    }
    // } catch (e) {
    //   AppUtils().debuglog(e);
    //   emit(ResultInitial());
    //   AppUtils().debuglog(12345678);
    // }
  }
}
