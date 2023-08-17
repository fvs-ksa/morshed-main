abstract class SubmitReportState {}

class InitialSubmitReportState extends SubmitReportState {}

class ChangeTabBarSubmitReportState extends SubmitReportState {}

class ChangeHelpWayReportState extends SubmitReportState {}

class ChangeNationalityReportState extends SubmitReportState {}
class GetMyReportSuccessState extends SubmitReportState {}
class GetMyReportLoadingState extends SubmitReportState {}
class GetMyReportErrorState extends SubmitReportState {
  final String error;
  GetMyReportErrorState({required this.error});
}
class GetAssistanceWaysSuccessState extends SubmitReportState {}
class GetAssistanceWaysLoadingState extends SubmitReportState {}
class GetAssistanceWaysErrorState extends SubmitReportState {
  final String error;
  GetAssistanceWaysErrorState({required this.error});
}class SelfReportSuccessState extends SubmitReportState {}
class SelfReportLoadingState extends SubmitReportState {}
class SelfReportErrorState extends SubmitReportState {
  final String error;
  SelfReportErrorState({required this.error});
}
class GetUserByIdSuccessState extends SubmitReportState {}
class GetUserByIdLoadingState extends SubmitReportState {}
class GetUserByIdErrorState extends SubmitReportState {
  final String error;
  GetUserByIdErrorState({required this.error});
}
