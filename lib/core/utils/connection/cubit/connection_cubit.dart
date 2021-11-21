import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connection_state.dart';

class ConnectionCheckerCubit extends Cubit<ConnectionCheckerState> {
  final InternetConnectionChecker? internetConnectionChecker;

  ConnectionCheckerCubit({required this.internetConnectionChecker})
      : super(InternetConnectionLoading()) {
    monitorInternetConnection();
  }

  // ignore: cancel_subscriptions
  StreamSubscription? internetConnectionStreamSubscription;

  void monitorInternetConnection() async {
    internetConnectionStreamSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          emitInternetConnectionConnected(InternetConnectionStatus.connected);
          break;
        case InternetConnectionStatus.disconnected:
          emitInternetConnectionDisconnected();
          break;
      }
    });
  }

  void emitInternetConnectionConnected(
          InternetConnectionStatus _internetConnectionStatus) =>
      emit(InternetConnectionConnected(
          internetConnectionStatus: _internetConnectionStatus));

  void emitInternetConnectionDisconnected() =>
      emit(InternetConnectionDisconnected());

  @override
  Future<void> close() async {
    internetConnectionStreamSubscription!.cancel();
    return super.close();
  }
}
