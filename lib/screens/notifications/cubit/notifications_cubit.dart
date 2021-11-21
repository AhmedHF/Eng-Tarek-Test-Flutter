import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/notification.dart';
import 'package:value_client/repositories/index.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  static final NotificationsDataProvider dataProvider =
      NotificationsDataProvider();
  static final NotificationsRepository repository =
      NotificationsRepository(dataProvider);

  final List<NotificationModel> notifications = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  Map<String, dynamic> query = {
    'page': 1,
    'limit': 10,
  };

  /// getNotifications
  void getNotifications(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['limit'] = 10;
      query.addAll(queryData);
    }

    if (query['page'] == 1) {
      emit(NotificationsLoadingState());
    } else {
      emit(NotificationsLoadingNextPageState());
    }

    repository.getNotifications(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(NotificationsErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;
          List<NotificationModel> _notifications = [];
          value.data.forEach((item) {
            _notifications.add(
              NotificationModel(
                id: item['id'],
                title: item['title'],
                message: item['message'],
                link: item['link'] ?? '',
                from: item['created_at'],
                isRead: item['is_read'],
              ),
            );
          });

          debugPrint('_Notifications ${_notifications.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            notifications.addAll(_notifications);
          } else {
            notifications.clear();
            notifications.addAll(_notifications);
          }
          if (notifications.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (notifications.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('notifications ${notifications.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(NotificationsSuccessState(notifications));
        }
      },
    );
  }

  String notifItemId = "-1";

  /// read Notifications
  void readNotification(id) {
    notifItemId = id;
    emit(ReadNotificationLoadingState());

    repository.readNotification(id).then(
      (value) {
        debugPrint('readNotification ==> ${value.toString()}');
        if (value.errorMessages != null) {
          emit(ReadNotificationErrorState(value.errorMessages!));
        } else {
          emit(ReadNotificationSuccessState(value.data));
        }
      },
    );
  }

  /// remove Notifications
  void removeNotification(id) {
    notifItemId = id;
    emit(ReadNotificationLoadingState());

    repository.removeNotification(id).then(
      (value) {
        debugPrint('removeNotification ==> ${value.toString()}');
        if (value.errorMessages != null) {
          emit(ReadNotificationErrorState(value.errorMessages!));
        } else {
          emit(ReadNotificationSuccessState(value.data));
        }
      },
    );
  }
}
