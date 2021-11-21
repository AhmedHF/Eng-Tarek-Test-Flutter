part of 'rated_offers_cubit.dart';

abstract class RatedOffersState extends Equatable {
  const RatedOffersState();

  @override
  List<Object> get props => [];
}

class RatedOffersInitial extends RatedOffersState {}

class RatedOffersLoadingState extends RatedOffersState {}

class RatedOffersLoadingNextPageState extends RatedOffersState {}

class RatedOffersSuccessState extends RatedOffersState {
  final List<DiscountModel> ratedOffers;
  const RatedOffersSuccessState(this.ratedOffers);
}

class RatedOffersErrorState extends RatedOffersState {
  final String error;
  const RatedOffersErrorState(this.error);
}

class ChangeSortType extends RatedOffersState {
  final SortType type;
  const ChangeSortType(this.type);
}
