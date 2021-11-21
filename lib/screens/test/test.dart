import 'package:flutter/material.dart';
import 'package:value_client/cubit/app_cubit.dart';
import 'package:value_client/models/user.dart';
import 'package:value_client/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    // final user = ModalRoute.of(context)!.settings.arguments as UserModel;
    // debugPrint('passing arguments =========== > $user');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('TestScreen'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.appHome);
            },
            child: const Text('go to home'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.signupScreen,
                arguments: UserModel(
                  id: 33,
                  name: 'Ahmed hassan',
                  email: 'ahmed.hassan@fudex.com',
                  phone: '01121499394',
                  image: 'image',
                  lat: "30.044420",
                  lng: "31.235712",
                  verificationCode: "1234",
                  isActive: true,
                  verified: true,
                ),
              );
            },
            child: const Text('go to sigup'),
          ),
          TextButton(
            onPressed: () {
              cubit.changeAppMode();
            },
            child: const Text('Change Mode '),
          ),
          Text(AppLocalizations.of(context)!.helloWorld),
          TextButton(
            onPressed: () {
              cubit.setLang(Locale('en'));
            },
            child: const Text('Change Language to en '),
          ),
          TextButton(
            onPressed: () {
              cubit.setLang(const Locale('ar'));
            },
            child: const Text('Change Language to ar '),
          ),
        ],
      ),
    );
  }
}
