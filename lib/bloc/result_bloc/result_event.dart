part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {}
class InitialEvent extends ResultEvent{

}
class FetchSessionResult extends ResultEvent {
  final String session;
  final String sessionId;

  FetchSessionResult(this.session,this.sessionId);
}
