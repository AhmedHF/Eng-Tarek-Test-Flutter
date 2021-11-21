import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';
import 'package:flutter/foundation.dart';

part 'my_values_state.dart';

class MyValuesCubit extends Cubit<MyValuesState> {
  MyValuesCubit() : super(MyValuesInitial());

  static MyValuesCubit get(context) => BlocProvider.of(context);

  static final MyValuesDataProvider dataProvider = MyValuesDataProvider();
  static final MyValuesRepository repository = MyValuesRepository(dataProvider);

  final List<DiscountModel> myValues = [];
  bool hasReachedEndOfResults = false;
  bool endLoadingFirstTime = false;
  Map<String, dynamic> query = {
    'page': 1,
    'limit': 10,
  };

  /// get my values
  void getMyValues(Map<String, dynamic> queryData) {
    if (queryData.isNotEmpty && queryData['loadMore'] != true) {
      query.clear();
      query['page'] = 1;
      query['limit'] = 10;
      query.addAll(queryData);
    }

    if (query['page'] == 1) {
      emit(MyValuesLoadingState());
    } else {
      emit(MyValuesLoadingNextPageState());
    }

    repository.getMyValues(query).then(
      (value) {
        if (value.errorMessages != null) {
          emit(MyValuesErrorState(value.errorMessages!));
        } else {
          endLoadingFirstTime = true;
          List<DiscountModel> _myValues = [];
          value.data.forEach((item) {
            _myValues.add(DiscountModel(
              id: item['id'],
              name: item['coupon']['name'],
              offer: item['coupon']['discount_amount'],
              image: item['coupon']['image'],
              description: item['coupon']['description'],
              expire: item['coupon']['expire'],
              expireDate: item['expire_at'],
              price: item['coupon']['price'],
              priceBeforeDiscount: item['coupon']['price_before_discount'],
              storeName: item['coupon']['store']['store_name'],
              storeImage: item['coupon']['store']['image'],
            ));
          });

          debugPrint('_myValues ${_myValues.length}');
          if (query['page'] != 1) {
            debugPrint('----- lode more ');
            myValues.addAll(_myValues);
          } else {
            myValues.clear();
            myValues.addAll(_myValues);
          }
          if (myValues.length == value.meta['total']) {
            debugPrint('============== done request');
            hasReachedEndOfResults = true;
          } else if (myValues.length < value.meta['total']) {
            hasReachedEndOfResults = false;
          }
          debugPrint('myValues ${myValues.length}');
          if (query['page'] < value.meta['last_page']) {
            debugPrint('load more 2222 page ++ ');
            query['page'] += 1;
          } else {
            query['page'] = 1;
          }

          emit(MyValuesSuccessState(myValues));
        }
      },
    );
  }

  /// get my value details
  void getMyValueDetails(id) {
    debugPrint('enter here');
    emit(MyValueDetailsLoadingState());
    repository.getValueById(id).then(
      (value) {
        if (value.errorMessages != null) {
          emit(MyValueDetailsErrorState(value.errorMessages!));
        } else {
          emit(MyValueDetailsSuccessState(value.data));
        }
      },
    );
  }

  /// get user coupon details
  void getUserCouponDetails(id) {
    emit(UserCouponDetailsLoadingState());
    repository.getUserCouponById(id).then(
      (value) {
        debugPrint('UserCouponDetails ==> ${value.toString()}');

        if (value.errorMessages != null) {
          emit(UserCouponDetailsErrorState(value.errorMessages!));
        } else {
          emit(UserCouponDetailsSuccessState(value.data));
        }
      },
    );
  }

  /// get user coupon details
  void getQR(id) {
    emit(GetQRLoadingState());
    repository.getQR(id).then(
      (value) {
        debugPrint('getQR ==> ${value.toString()}');
        // if (value.errorMessages != null) {
        //   emit(GetQRErrorState(value.errorMessages!));
        // } else {
        emit(GetQRSuccessState(value));
        // }
      },
    );
  }
}
