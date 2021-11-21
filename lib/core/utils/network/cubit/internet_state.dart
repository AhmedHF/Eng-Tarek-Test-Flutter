part of 'internet_cubit.dart';

abstract class InternetConnectionTypeState {}

class InternetConnectionTypeLoading extends InternetConnectionTypeState {}

class InternetConnectionType extends InternetConnectionTypeState {
  final ConnectionType? connectionType;

  InternetConnectionType({required this.connectionType});
}
