part of 'gift_cubit.dart';

abstract class GiftStates extends Equatable {
  const GiftStates();

  @override
  List<Object> get props => [];
}

class AppInitial extends GiftStates {}

class SendGiftLoadingState extends GiftStates {}

class SendGiftSuccessState extends GiftStates {
  final String sendGift;
  SendGiftSuccessState(this.sendGift);
}

class SendGiftErrorState extends GiftStates {
  final String error;
  SendGiftErrorState(this.error);
}
