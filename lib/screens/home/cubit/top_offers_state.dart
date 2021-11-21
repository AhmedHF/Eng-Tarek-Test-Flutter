part of 'top_offers_cubit.dart';

abstract class TopOffersState extends Equatable {
  const TopOffersState();

  @override
  List<Object> get props => [];
}

class TopOffersInitial extends TopOffersState {}

class TopRatedOffersLoadingState extends TopOffersState {}

class TopRatedOffersSuccessState extends TopOffersState {
  final List<DiscountModel> topRatedOffers;
  TopRatedOffersSuccessState(this.topRatedOffers);
}

class TopRatedOffersErrorState extends TopOffersState {
  final String error;
  TopRatedOffersErrorState(this.error);
}
