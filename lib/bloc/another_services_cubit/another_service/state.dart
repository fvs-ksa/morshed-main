abstract class AnotherServicesState{}
class InitialAnotherServicesState extends AnotherServicesState{}
class GetTransportationLoadingState extends AnotherServicesState{}
class GetTransportationSuccessState extends AnotherServicesState{}
class GetTransportationErrorState extends AnotherServicesState{
  final String error;
  GetTransportationErrorState({required this.error});
}