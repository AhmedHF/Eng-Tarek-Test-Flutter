part of 'user_membership_cubit.dart';

abstract class UserMembershipState extends Equatable {
  const UserMembershipState();

  @override
  List<Object> get props => [];
}

class UserMembershipInitial extends UserMembershipState {}

class UserMemberShipLoadingState extends UserMembershipState {}

class UserMemberShipSuccessState extends UserMembershipState {
  final Map<String, dynamic> userMemberShip;
  const UserMemberShipSuccessState(this.userMemberShip);
}

class UserMemberShipErrorState extends UserMembershipState {
  final String error;
  const UserMemberShipErrorState(this.error);
}
