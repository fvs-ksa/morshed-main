abstract class BoardingState {}

class InitialBoardingState extends BoardingState {}

class ChangeBoardingState extends BoardingState {}

class RemoveNativeSplashState extends BoardingState {}

class ChangeAccountTypeState extends BoardingState {}
class ConvertLocationFromMapSuccessState extends BoardingState {}
class ChangeAddressState extends BoardingState {}
class GetCurrentLocationLoadingState extends BoardingState {}
class GetCurrentLocationSuccessState extends BoardingState {}
class GetPlacesSuccessState extends BoardingState {}
class GetCurrentLocationErrorState extends BoardingState {
  final String error;
  GetCurrentLocationErrorState({required this.error});
}
class GetUserCurrentLocation extends BoardingState {}
// class GetCompaniesLoadingState extends BoardingState{}
// class GetCompaniesSuccessState extends BoardingState{}
// class GetCompaniesErrorState extends BoardingState {
//   final String error;
//
//   GetCompaniesErrorState({required this.error});
// }