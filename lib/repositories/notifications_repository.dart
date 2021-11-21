import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class NotificationsRepository implements NotificationsInterface {
  final NotificationsDataProvider notificationsDataProvider;

  const NotificationsRepository(this.notificationsDataProvider);

  @override
  Future<AppResponse> getNotifications(query) {
    return notificationsDataProvider.getNotifications(query);
  }

  @override
  Future<AppResponse> readNotification(id) {
    return notificationsDataProvider.readNotification(id);
  }

  @override
  Future<AppResponse> removeNotification(id) {
    return notificationsDataProvider.removeNotification(id);
  }
}
