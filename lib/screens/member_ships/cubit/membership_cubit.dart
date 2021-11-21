import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/membership_repository.dart';

part 'membership_state.dart';

class MembershipCubit extends Cubit<MembershipState> {
  MembershipCubit() : super(MembershipInitial());
  static MembershipCubit get(context) => BlocProvider.of(context);

  static final dataProvider = MembershipDataProvider();
  static final MembershipRepository repository =
      MembershipRepository(dataProvider);

  final List<MemberShipModel> memberships = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  Map<String, dynamic> query = {
    'page': 1,
    'limit': 10,
  };

  /// get memberShipe
  void getMemberShips(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      debugPrint('object 1 ');
      query.clear();
      query['page'] = 1;
      query['limit'] = 10;
      query.addAll(queryData);
    }
    if (query['page'] == 1) {
      emit(MemberShipsLoadingState());
    } else {
      emit(MemberShipsLoadingNextPageState());
    }

    repository.getMemberships().then(
      (value) {
        if (value.errorMessages != null) {
          emit(MemberShipsErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;

          List<MemberShipModel> _memberships = [];

          value.data.forEach((item) {
            _memberships.add(MemberShipModel(
              id: item['id'],
              name: item['name'],
              description: item['description'],
              price: item['price'],
              days: item['days'],
            ));
          });

          debugPrint('_myValues ${_memberships.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            memberships.addAll(_memberships);
          } else {
            memberships.clear();
            memberships.addAll(_memberships);
          }
          if (memberships.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (memberships.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(MemberShipsSuccessState(memberships));
        }
      },
    );
  }

  /// checkout
  void checkout(Map<String, dynamic> data) {
    emit(CheckoutMemberShipLoadingState());

    repository.checkout(data).then(
      (value) {
        debugPrint('VALUE: $value}', wrapWidth: 1024);
        if (value.errorMessages != null) {
          emit(CheckoutMemberShipErrorState(value.errorMessages!));
        } else if (value.errors != null) {
          emit(CheckoutMemberShipErrorState(value.errors!));
        } else {
          emit(CheckoutMemberShipSuccessState(value.data));
        }
      },
    );
  }
}
