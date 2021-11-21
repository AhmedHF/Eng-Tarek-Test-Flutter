import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/components/index.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/screens/notifications/cubit/notifications_cubit.dart';
import 'package:value_client/widgets/index.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(),
      child: Scaffold(
        appBar:
            AppBar(title: Text(AppLocalizations.of(context)!.notifications)),
        body: NetworkSensitive(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(10)),
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                NotificationsCubit cubit = NotificationsCubit.get(context);
                return AppList(
                  key: const Key('Notifications List'),
                  fetchPageData: (query) => cubit.getNotifications(query),
                  loadingListItems: state is NotificationsLoadingState,
                  hasReachedEndOfResults: cubit.hasReachedEndOfResults,
                  endLoadingFirstTime: cubit.endLoadingFirstTime,
                  itemBuilder: (context, index) => NotificationItem(
                      item: cubit.notifications[index],
                      onFinish: () => cubit.getNotifications({})),
                  listItems: cubit.notifications,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
