part of 'top_discount_cubit.dart';

abstract class TopDiscountState extends Equatable {
  const TopDiscountState();

  @override
  List<Object> get props => [];
}

class TopDiscountInitial extends TopDiscountState {}

class TopDiscountLoadingState extends TopDiscountState {}

class TopDiscountSuccessState extends TopDiscountState {
  final List<DiscountModel> topDiscount;
  const TopDiscountSuccessState(this.topDiscount);
}

class TopDiscountErrorState extends TopDiscountState {
  final String error;
  const TopDiscountErrorState(this.error);
}
