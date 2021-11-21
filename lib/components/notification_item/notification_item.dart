import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/dynamic_links_service.dart';
import 'package:value_client/models/notification.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/index.dart';
import 'package:value_client/screens/notifications/cubit/notifications_cubit.dart';
import 'package:value_client/widgets/app_loading.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel item;
  final Function onFinish;
  const NotificationItem({
    Key? key,
    required this.item,
    required this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        NotificationsCubit cubit = NotificationsCubit.get(context);

        if (state is ReadNotificationErrorState &&
            cubit.notifItemId == item.id) {
          debugPrint('=== errrrrror ');
          // AppSnackBar.showError(context, state.error);
        } else if (state is ReadNotificationSuccessState &&
            cubit.notifItemId == item.id) {
          debugPrint('=== message ');
          // AppSnackBar.showSuccess(context, AppLocalizations.of(context)!.done);
          onFinish();
        }
      },
      builder: (context, state) {
        NotificationsCubit cubit = NotificationsCubit.get(context);
        AppCubit appCubit = AppCubit.get(context);
        return InkWell(
          onTap: () {
            if (!item.isRead) {
              cubit.readNotification(item.id);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ' ${DateFormat('d ,MMM ,y', appCubit.locale.languageCode).format(DateTime.parse(item.from))}',
                      style: const TextStyle(
                        color: AppColors.grayText,
                        fontSize: 16,
                      ),
                    ),
                    Slidable(
                      actionPane: const SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      actions: appCubit.isRTL(context)
                          ? <Widget>[
                              deleteIcon(cubit, context),
                            ]
                          : [],
                      secondaryActions: !appCubit.isRTL(context)
                          ? <Widget>[
                              deleteIcon(cubit, context),
                            ]
                          : [],
                      child: Card(
                        color: AppColors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: item.isRead == true
                                ? AppColors.primaryLightL.withOpacity(.1)
                                : AppColors.primaryLightL.withOpacity(.8),
                            radius: 25,
                            child: const Icon(
                              Icons.import_contacts_sharp,
                              color: AppColors.primaryL,
                            ),
                          ),
                          title: Text(
                            item.message,
                            style: const TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              if (item.link != '')
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 25),
                                  ),
                                  child: Text(
                                    item.link,
                                    style: const TextStyle(
                                      color: AppColors.primaryL,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onPressed: () {
                                    openURL(item.link);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state is ReadNotificationLoadingState &&
                    cubit.notifItemId == item.id)
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AppLoading(
                      color: AppColors.primaryL,
                      scale: 0.4,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget deleteIcon(cubit, context) {
    return IconSlideAction(
      color: AppColors.red,
      iconWidget: const Icon(
        AppIcons.delete,
        color: Colors.white,
        size: 30,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: AppColors.white,
            title: Text(AppLocalizations.of(context)!.are_you_sure),
            content: Text(
              AppLocalizations.of(context)!.remove_notif_confirm,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                // color: AppColors.grayText,
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                  cubit.removeNotification(item.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
