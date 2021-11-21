import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/utils/connection/cubit/connection_cubit.dart';
import 'package:value_client/widgets/index.dart';
import 'package:value_client/widgets/network/no_internet.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;

  const NetworkSensitive({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ConnectionCheckerCubit, ConnectionCheckerState>(
        builder: (context, state) {
          if (state is InternetConnectionDisconnected) {
            return const NoInterNetConnection();
          } else if (state is InternetConnectionConnected) {
            return child;
          } else {
            return const AppLoading(color: Colors.red);
          }
        },
      ),
    );
  }
}
