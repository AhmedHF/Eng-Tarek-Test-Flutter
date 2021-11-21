part of 'my_values_cubit.dart';

abstract class MyValuesState extends Equatable {
  const MyValuesState();

  @override
  List<Object> get props => [];
}

class MyValuesInitial extends MyValuesState {}

class MyValuesLoadingState extends MyValuesState {}

class MyValuesLoadingNextPageState extends MyValuesState {}

class MyValuesSuccessState extends MyValuesState {
  final List<DiscountModel> myValues;
  const MyValuesSuccessState(this.myValues);
}

class MyValuesErrorState extends MyValuesState {
  final String error;
  const MyValuesErrorState(this.error);
}

class MyValueDetailsLoadingState extends MyValuesState {}

class MyValueDetailsSuccessState extends MyValuesState {
  final Map<String, dynamic> myValueDetails;
  const MyValueDetailsSuccessState(this.myValueDetails);
}

class MyValueDetailsErrorState extends MyValuesState {
  final String error;
  const MyValueDetailsErrorState(this.error);
}

// UserCoupon details
class UserCouponDetailsLoadingState extends MyValuesState {}

class UserCouponDetailsSuccessState extends MyValuesState {
  final Map<String, dynamic> userCouponDetails;
  const UserCouponDetailsSuccessState(this.userCouponDetails);
}

class UserCouponDetailsErrorState extends MyValuesState {
  final String error;
  const UserCouponDetailsErrorState(this.error);
}

// GetQR details
class GetQRLoadingState extends MyValuesState {}

class GetQRSuccessState extends MyValuesState {
  final String data;
  const GetQRSuccessState(this.data);
}

class GetQRErrorState extends MyValuesState {
  final String error;
  const GetQRErrorState(this.error);
}
