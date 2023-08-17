abstract class AddCompanionsState {}

class InitialAddCompanionsState extends AddCompanionsState {}

class ChooseDateOfBirthState extends AddCompanionsState {}
class AddCompanionSuccessState extends AddCompanionsState {}
class AddCompanionLoadingState extends AddCompanionsState {}
class AddCompanionErrorState extends AddCompanionsState {
  final String error;
  AddCompanionErrorState({required this.error});
}
class GetCompanionSuccessState extends AddCompanionsState {}
class GetCompanionLoadingState extends AddCompanionsState {}
class GetCompanionErrorState extends AddCompanionsState {
  final String error;
  GetCompanionErrorState({required this.error});
}
