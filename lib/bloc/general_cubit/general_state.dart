abstract class GeneralState {}

class InitialGeneralState extends GeneralState {}

class ChangeBottomNavigationBarState extends GeneralState {}
class RemoveNativeSplashState extends GeneralState {}
class GetProfileLoadingState extends GeneralState {}
class GetProfileSuccessState extends GeneralState{}
class GetProfileErrorState extends GeneralState{
  final String error;
  GetProfileErrorState({required this.error});
}