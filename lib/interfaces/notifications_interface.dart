import 'package:value_client/models/index.dart';

abstract class NotificationsInterface {
  Future<AppResponse> getNotifications(query);
  Future<AppResponse> readNotification(id);
  Future<AppResponse> removeNotification(id);
}
