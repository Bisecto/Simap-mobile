part of 'app_bloc.dart';

abstract class AppEvent {}

class InitialEvent extends AppEvent {}

class GetSchoolsEvent extends AppEvent {}

class SetUpSchoolEvent extends AppEvent {
  SchoolModel schoolModel;

  SetUpSchoolEvent(this.schoolModel);
}
