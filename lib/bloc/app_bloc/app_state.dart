part of 'app_bloc.dart';

@immutable
abstract class AppState {}

final class AppInitial extends AppState {}

class LoadingState extends AppState {}

class ErrorState extends AppState {
  final String error;

  ErrorState(this.error);
}

class GetSchoolsSuccessState extends AppState {
  final List<SchoolModel> listOfSchools;

  GetSchoolsSuccessState(
      this.listOfSchools,
      );
}
class AccessTokenExpireState extends AppState {}
