abstract class NotificationState{}
class InitialNotificationState extends NotificationState{}
class GetNotificationLoadingState extends NotificationState{}
class GetNotificationSuccessState extends NotificationState{}
class GetNotificationErrorState extends NotificationState{
  final String error;
  GetNotificationErrorState({required this.error});
}