abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class ChangeNationalityDropDownProfileState extends ProfileState {}
class ChangeDisabilityDropDownState extends ProfileState {}

class ChooseDateOfBirthProfileState extends ProfileState {}
class GetProfileLoadingState extends ProfileState {}
class GetProfileSuccessState extends ProfileState{}
class GetProfileErrorState extends ProfileState{
  final String error;
  GetProfileErrorState({required this.error});
}
class UpdateProfileLoadingState extends ProfileState {}
class UpdateProfileSuccessState extends ProfileState{}
class UpdateProfileErrorState extends ProfileState{
  final String error;
  UpdateProfileErrorState({required this.error});
}
class LogOutLoadingState extends ProfileState {}
class LogOutSuccessState extends ProfileState{}
class LogOutErrorState extends ProfileState{
  final String error;
  LogOutErrorState({required this.error});
}

class GetAllNationalityLoadingState extends ProfileState{}
class GetAllNationalitySuccessState extends ProfileState{}
class GetAllNationalityErrorState extends ProfileState{
  final String error;
  GetAllNationalityErrorState({required this.error});
}

