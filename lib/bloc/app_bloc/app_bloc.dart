import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:simap/model/school_model.dart';
import 'package:simap/res/shared_preferenceKey.dart';
import 'package:simap/utills/shared_preferences.dart';

import '../../app_repository/repository.dart';
import '../../res/tem_data/tem_data.dart';
import '../../utills/app_utils.dart';
import '../../utills/constants/loading_dialog.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<InitialEvent>(initialEvent);
    on<GetSchoolsEvent>(getSchoolsEvent);
    on<SetUpSchoolEvent>(setUpSchoolEvent);
    // on<AppEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  FutureOr<void> initialEvent(InitialEvent event, Emitter<AppState> emit) {
    emit(AppInitial());
  }

  FutureOr<void> getSchoolsEvent(
      GetSchoolsEvent event, Emitter<AppState> emit) async {
    emit(LoadingState());
    AppRepository repository = AppRepository();
    //try {
    final getSchoolsResponse = await repository.getRequest('');

    AppUtils().debuglog(getSchoolsResponse.statusCode);
    if (getSchoolsResponse.statusCode == 200 ||
        getSchoolsResponse.statusCode == 201) {
      AppUtils().debuglog(getSchoolsResponse.body);
      AppUtils().debuglog(getSchoolsResponse.body);
      List<dynamic> schoolJsonResponse =
          json.decode(AppTemData().schools)['schools'];

      List<SchoolModel> schoolList =
          schoolJsonResponse.map((item) => SchoolModel.fromJson(item)).toList();
      AppUtils().debuglog("Successss");
      emit(GetSchoolsSuccessState(schoolList));
    } else if (getSchoolsResponse.statusCode == 401) {
      emit(AccessTokenExpireState());
    } else if (getSchoolsResponse.statusCode == 500 ||
        getSchoolsResponse.statusCode == 501) {
      emit(ErrorState(
          "There was a problem getting schools please try again later."));
      emit(AppInitial());
    } else {
      emit(ErrorState("There was a problem fetching schools"));
      //AppUtils().debuglog(event.password);
      //AppUtils().debuglog(json.decode(response.body));
      emit(AppInitial());
    }
    // } catch (e) {
    //   AppUtils().debuglog(e);
    //   //emit(AppInitial());
    //   AppUtils().debuglog(12345678);
    // }
  }

  Future<void> setUpSchoolEvent(
      SetUpSchoolEvent event, Emitter<AppState> emit) async {
    //SharedPref sharedPref = SharedPref();
    showDialog(
        barrierDismissible: false,
        context: event.context,
        builder: (_) {
          return const LoadingDialog('Setting up...');
        });
    await SharedPref.putString(
      SharedPreferenceKey().appSchoolLogoKey,
      event.schoolModel.logoUrl,
    );
    await SharedPref.putString(
      SharedPreferenceKey().appSchoolNameKey,
      event.schoolModel.name,
    );
    await SharedPref.putString(
      SharedPreferenceKey().baseUrlKey,
      event.schoolModel.schoolBaseUrl,
    );
    await SharedPref.putString(
      SharedPreferenceKey().appSchoolAddressKey,
      event.schoolModel.address,
    );
    await SharedPref.putString(
      SharedPreferenceKey().userPreferenceKey,
      event.userPreference,
    );
    Navigator.pop(event.context);
    emit(SetUpSuccessState());
  }
}
