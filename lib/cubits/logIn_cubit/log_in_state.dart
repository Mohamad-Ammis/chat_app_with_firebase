
class LogInState {}

final class LogInInitial extends LogInState {}
final class LogInLoading extends LogInState {}
final class LogInSuccess extends LogInState {}
final class LogInFailure extends LogInState {
  String errMsg;
  LogInFailure({required this.errMsg});
}
