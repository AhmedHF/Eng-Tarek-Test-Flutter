part of 'membership_cubit.dart';

abstract class MembershipState extends Equatable {
  const MembershipState();

  @override
  List<Object> get props => [];
}

class MembershipInitial extends MembershipState {}

class MemberShipsLoadingState extends MembershipState {}

class MemberShipsLoadingNextPageState extends MembershipState {}

class MemberShipsSuccessState extends MembershipState {
  final List<MemberShipModel> memberShip;
  const MemberShipsSuccessState(this.memberShip);
}

class MemberShipsErrorState extends MembershipState {
  final String error;
  const MemberShipsErrorState(this.error);
}

/// checkout
class CheckoutMemberShipLoadingState extends MembershipState {}

class CheckoutMemberShipSuccessState extends MembershipState {
  final Map<String, dynamic> data;
  const CheckoutMemberShipSuccessState(this.data);
}

class CheckoutMemberShipErrorState extends MembershipState {
  final String error;
  const CheckoutMemberShipErrorState(this.error);
}
