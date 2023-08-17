abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class ChangeNationalityDropDownState extends RegisterState {}
class ChangeCompanyDropDownState extends RegisterState {}

class ChangeDisabilityDropDownState extends RegisterState {}

class ChangeResidenceDropDownState extends RegisterState {}

class ChooseDateOfBirthState extends RegisterState {}

class ChangeDisabilitySwitchValueState extends RegisterState {}
class GetPlacesSuccessState extends RegisterState {}
class GetUserCurrentLocation extends RegisterState{}
class ConvertLocationFromMapSuccessState extends RegisterState{}
class GetCurrentLocationLoadingState extends RegisterState{}
class GetCurrentLocationSuccessState extends RegisterState{}
class GetCurrentLocationErrorState extends RegisterState{
  final String error;
  GetCurrentLocationErrorState({required this.error});
}
class ChangeAddressState extends RegisterState{}
class PickImageFromCameraState extends RegisterState{}
class PickImageFromGalleryState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSuccessState extends RegisterState{}
class RegisterErrorState extends RegisterState{
 final String error;
  RegisterErrorState({required this.error});
}
class SendFcmTokenLoadingState extends RegisterState{}
class SendFcmTokenSuccessState extends RegisterState{}
class SendFcmTokenErrorState extends RegisterState{
  final String error;
  SendFcmTokenErrorState({required this.error});
}
class ChangeVisabilityState extends RegisterState{}
class GetCompaniesLoadingState extends RegisterState{}
class GetCompaniesSuccessState extends RegisterState{}
class GetCompaniesErrorState extends RegisterState {
  final String error;

  GetCompaniesErrorState({required this.error});
}
class ChangeKeyboardState extends RegisterState{}

class GetAllNationalityLoadingState extends RegisterState{}
class GetAllNationalitySuccessState extends RegisterState{}
class GetAllNationalityErrorState extends RegisterState{
  final String error;
  GetAllNationalityErrorState({required this.error});
}