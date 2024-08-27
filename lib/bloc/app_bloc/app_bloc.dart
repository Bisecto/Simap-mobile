import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simap/model/school_model.dart';

import '../../app_repository/repository.dart';
import '../../res/tem_data/tem_data.dart';
import '../../utills/app_utils.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial()) {
    on<InitialEvent>(initialEvent);
    on<GetSchoolsEvent>(getSchoolsEvent);
    // on<AppEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  FutureOr<void> initialEvent(InitialEvent event, Emitter<AppState> emit) {}

  FutureOr<void> getSchoolsEvent(
      GetSchoolsEvent event, Emitter<AppState> emit) async {
    emit(LoadingState());
    AppRepository repository = AppRepository();
    try {
      final getSchoolsResponse = await repository.getRequest('');

      AppUtils().debuglog(getSchoolsResponse.statusCode);
      if (getSchoolsResponse.statusCode == 200 ||
          getSchoolsResponse.statusCode == 201)
      {
        AppUtils().debuglog(getSchoolsResponse.body);
        AppUtils().debuglog(getSchoolsResponse.body);
        List<dynamic> schoolJsonResponse = json.decode(AppTemData().schools)['schools'];

        List<SchoolModel> schoolList = schoolJsonResponse
            .map((item) => SchoolModel.fromJson(item))
            .toList();
        AppUtils().debuglog("Successss");
        emit(GetSchoolsSuccessState(schoolList));
      } else if (getSchoolsResponse.statusCode == 401) {
        emit(AccessTokenExpireState());
      } else if (getSchoolsResponse.statusCode == 500 ||
          getSchoolsResponse.statusCode == 501) {
        emit(ErrorState(
            "There was a problem getting GST courses please try again later."));
        emit(AppInitial());
      } else {
        emit(ErrorState(
            "There was a problem fetching GST Unregistered Courses"));
        //AppUtils().debuglog(event.password);
        //AppUtils().debuglog(json.decode(response.body));
        emit(AppInitial());
      }
    } catch (e) {
      AppUtils().debuglog(e);
      //emit(AppInitial());
      AppUtils().debuglog(12345678);
    }
  }
}
