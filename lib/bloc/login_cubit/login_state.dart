abstract class LoginState{}
class InitialLoginState extends LoginState{}
class ChangeVisabilityState extends LoginState{}
class LoginSuccessState extends LoginState{}
class LoginLoadingState extends LoginState{}
class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState({required this.error});
}
class GetProfileSuccessState extends LoginState{}
class GetProfileLoadingState extends LoginState{}
class GetProfileErrorState extends LoginState{
  final String error;
  GetProfileErrorState({required this.error});
}
class SendFcmTokenSuccessState extends LoginState{}
class SendFcmTokenLoadingState extends LoginState{}
class SendFcmTokenErrorState extends LoginState{
  final String error;
  SendFcmTokenErrorState({required this.error});
}
///moetamer
class LoginMoetamerSuccessState extends LoginState{}
class LoginMoetamerLoadingState extends LoginState{}
class LoginMoetamerErrorState extends LoginState{
  final String error;
  LoginMoetamerErrorState({required this.error});
}