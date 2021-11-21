part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class NotificationsLoadingNextPageState extends NotificationsState {}

class NotificationsSuccessState extends NotificationsState {
  final List<NotificationModel> notifications;
  const NotificationsSuccessState(this.notifications);
}

class NotificationsErrorState extends NotificationsState {
  final String error;
  const NotificationsErrorState(this.error);
}

//read notif
class ReadNotificationLoadingState extends NotificationsState {}

class ReadNotificationSuccessState extends NotificationsState {
  final Map<String, dynamic> data;
  const ReadNotificationSuccessState(this.data);
}

class ReadNotificationErrorState extends NotificationsState {
  final String error;
  const ReadNotificationErrorState(this.error);
}

//removeotif
class RemoveNotificationLoadingState extends NotificationsState {}

class RemoveNotificationSuccessState extends NotificationsState {
  final Map<String, dynamic> data;
  const RemoveNotificationSuccessState(this.data);
}

class RemoveNotificationErrorState extends NotificationsState {
  final String error;
  const RemoveNotificationErrorState(this.error);
}
