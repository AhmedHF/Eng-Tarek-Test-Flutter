import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/resources/colors/colors.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:value_client/screens/menu/menu.dart';
import 'package:value_client/widgets/alert_dialogs/login_alert_dialog.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          key: _scaffoldKey,
          body: cubit.screens[cubit.selectedIndex],
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              cubit.getTitles(
                context,
              )[cubit.selectedIndex],
            ),
            leading: Container(),
            actions: cubit.selectedIndex == 0
                ? [
                    IconButton(
                      onPressed: () {
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
                      icon: const Icon(Icons.notifications),
                    ),
                  ]
                : [],
          ),
          drawer: const MenuScreen(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: cubit.getItems(context),
            currentIndex: cubit.selectedIndex,
            selectedItemColor: AppColors.secondaryL,
            onTap: (index) {
              if (index == 3) {
                _scaffoldKey.currentState!.openDrawer();
              } else {
                cubit.onItemTapped(index);
              }
            },
            showUnselectedLabels: true,
            unselectedItemColor: AppColors.white,
            backgroundColor: AppColors.primaryL,
            elevation: 40,
          ),
        );
      },
    );
  }
}
