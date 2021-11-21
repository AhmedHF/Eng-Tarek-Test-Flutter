import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/resources/images/index.dart';
import 'package:value_client/resources/styles/icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/widgets/alert_dialogs/login_alert_dialog.dart';
import 'package:value_client/widgets/index.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    // debugPrint('user in menu${cubit.userData.user.toString()}');
    return SafeArea(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        elevation: 10,
        child: NetworkSensitive(
          child: Stack(
            children: <Widget>[
              Image.asset(
                AppImages.background,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        // DrawerHeader(
                        //     child: Padding(
                        //         padding: EdgeInsets.only(right: 10, top: 10),
                        //         child: Container(
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Row(
                        //                 children: <Widget>[
                        //                   Stack(
                        //                     children: <Widget>[
                        //                       CircleAvatar(
                        //                         radius: 35,
                        //                         child: Image.asset(
                        //                           AppImages.avatar,
                        //                         ),
                        //                       ),
                        //                       Container(
                        //                         child: Positioned(
                        //                           right: 0.0,
                        //                           bottom: 0.0,
                        //                           child: CircleAvatar(
                        //                               radius: 12,
                        //                               backgroundColor: AppColors.white,
                        //                               child: Container(
                        //                                 child: Icon(
                        //                                   AppIcons.write,
                        //                                   size: 10,
                        //                                 ),
                        //                               )),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                   Container(
                        //                     margin: EdgeInsets.symmetric(horizontal: 10),
                        //                     child: Text(
                        //                       "Name",
                        //                       style: TextStyle(
                        //                           color: AppColors.white, fontSize: 18),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //               Container(
                        //                 child: IconButton(
                        //                   onPressed: () => Navigator.pop(context),
                        //                   icon: Icon(
                        //                     AppIcons.close,
                        //                     size: 20,
                        //                     color: AppColors.white,
                        //                   ),
                        //                 ),
                        //               )
                        //             ],
                        //           ),
                        //         ))),
                        const SizedBox(height: 25),
                        BlocBuilder<AppCubit, AppStates>(
                          builder: (context, state) {
                            AppCubit cubit = AppCubit.get(context);
                            return ListTile(
                              leading: cubit.userData.user == null
                                  ? ClipRRect(
                                      // borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                      AppImages.logo,
                                      fit: BoxFit.cover,
                                    ))
                                  : Stack(
                                      children: <Widget>[
                                        // CircleAvatar(
                                        //   radius: 35,
                                        //   backgroundColor: AppColors.primaryL,
                                        //   child:
                                        cubit.userData.user!.image != null
                                            ? ClipOval(
                                                // borderRadius: BorderRadius.circular(15),
                                                child: Image.network(
                                                cubit.userData.user!.image
                                                    as String,
                                                // fit: BoxFit.cover,
                                                width: 55,
                                                height: 55,
                                              ))
                                            : Image.asset(
                                                AppImages.logo,
                                                fit: BoxFit.cover,
                                              ),
                                        // ),
                                        // Container(
                                        //   child: Positioned(
                                        //     left: 0.0,
                                        //     bottom: 0.0,
                                        //     child: CircleAvatar(
                                        //         radius: 15,
                                        //         backgroundColor:
                                        //             Color.fromRGBO(255, 255, 255, .6),
                                        //         child: Container(
                                        //             child: IconButton(
                                        //           icon: Icon(
                                        //             AppIcons.write,
                                        //             size: 12,
                                        //           ),
                                        //           onPressed: () => Navigator.of(context)
                                        //               .pushNamed(AppRoutes.profileScreen),
                                        //         ))),
                                        //   ),
                                        // )
                                      ],
                                    ),
                              title: Text(
                                cubit.userData.user == null
                                    ? ""
                                    : cubit.userData.user!.name == null
                                        ? ""
                                        : cubit.userData.user!.name.toString(),
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () =>
                                    Scaffold.of(context).openEndDrawer(),
                                icon: const Icon(
                                  AppIcons.close,
                                  size: 16,
                                  color: AppColors.white,
                                ),
                              ),
                              onTap: () {
                                // Update the state of the app.
                                // ...
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 25),

                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.account,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            if (cubit.userData.user == null) {
                              debugPrint('zzzzzzzzzzzzzzzzz');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const LoginAlertDialog(),
                              );
                            } else {
                              debugPrint('xxxxxxxxxxxxx');
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.profileScreen);
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.card_membership,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.membership,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            if (cubit.userData.user == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const LoginAlertDialog(),
                              );
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.memberShipScreen);
                            }
                          },
                        ),
                        // ListTile(
                        //   leading: const Icon(
                        //     AppIcons.ribbon,
                        //     size: 30,
                        //   ),
                        //   title: Text(
                        //     AppLocalizations.of(context)!.savings,
                        //     style: const TextStyle(
                        //       color: AppColors.white,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     if (cubit.userData.user == null) {
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) =>
                        //             const LoginAlertDialog(),
                        //       );
                        //     } else {
                        //       Navigator.of(context).pushNamed(AppRoutes.savingsScreen);
                        //     }
                        //   },
                        // ),
                        // ListTile(
                        //   leading: const Icon(
                        //     AppIcons.user_follow,
                        //     size: 30,
                        //   ),
                        //   title: Text(
                        //     AppLocalizations.of(context)!.followings,
                        //     style: const TextStyle(
                        //       color: AppColors.white,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     if (cubit.userData.user == null) {
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) =>
                        //             const LoginAlertDialog(),
                        //       );
                        //     } else {
                        //       Navigator.of(context)
                        //           .pushNamed(AppRoutes.followingsScreen);
                        //     }
                        //   },
                        // ),

                        ListTile(
                          leading: const Icon(
                            AppIcons.two_tone,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.notifications,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            if (cubit.userData.user == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const LoginAlertDialog(),
                              );
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.notificationsScreen);
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            AppIcons.mobile_phone,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.contact_us,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.contactUsScreen),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.help_outline,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.about_us,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.aboutusScreen);
                          },
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          height: 5,
                          color: AppColors.white,
                        ),
                        const SizedBox(height: 5),
                        ListTile(
                          leading: const Icon(
                            Icons.language_outlined,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.language,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.changeLanguageScreen),
                        ),
                        ListTile(
                          leading: const Icon(
                            AppIcons.write,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.privacy_policy,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.privacyScreen);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            AppIcons.file,
                            size: 30,
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.terms_and_conditions,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.termsScreen);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(
                    height: 5,
                    color: AppColors.white,
                  ),
                  // const SizedBox(height: 5),
                  BlocBuilder<AppCubit, AppStates>(
                    builder: (context, state) {
                      return ListTile(
                        leading: const Icon(
                          Icons.logout,
                          size: 30,
                        ),
                        title: state is LogoutLoadingState
                            ? const Center(
                                child: AppLoading(
                                  color: AppColors.white,
                                ),
                              )
                            : Text(
                                cubit.userData.user == null
                                    ? AppLocalizations.of(context)!.login
                                    : AppLocalizations.of(context)!.logout,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        onTap: () {
                          if (state is LogoutLoadingState) {
                            return;
                          }
                          if (cubit.userData.user == null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.loginScreen, (route) => false);
                          } else {
                            cubit.logout();
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
