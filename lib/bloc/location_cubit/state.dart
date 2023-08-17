abstract class LocationState{}
class InitialLocationState extends LocationState{}
class GetPlacesSuccessState extends LocationState{}
class GetUserCurrentLocation extends LocationState{}
class ConvertLocationFromMapSuccessState extends LocationState{}
class GetCurrentLocationLoadingState extends LocationState{}
class GetCurrentLocationSuccessState extends LocationState{}
class GetCurrentLocationErrorState extends LocationState{
  final String error;
  GetCurrentLocationErrorState({required this.error});
}
class ChangeAddressState extends LocationState{}
