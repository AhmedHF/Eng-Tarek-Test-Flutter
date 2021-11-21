import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:value_client/core/utils/utils.dart';
import 'package:value_client/data_sources/index.dart';
import 'package:value_client/models/index.dart';
import 'package:value_client/repositories/index.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  static final dataProvider = SearchDataProvider();

  static final SearchRepository repository = SearchRepository(dataProvider);

  SortByDateType myValuesSortBy = SortByDateType.purchased;

  void setMyValuesSortType(SortByDateType type) {
    myValuesSortBy = type;
    emit(ChangeMyValuesSortType(type));
  }

  /// get categories
  void getCategories() {
    emit(CategoriesLoadingState());
    repository.getCategories().then(
      (value) {
        if (value.errorMessages != null) {
          emit(CategoriesErrorState(value.errorMessages!));
        } else {
          debugPrint('--------------------------------');
          List<CheckBoxModal> categories = [];

          value.data.forEach((item) {
            categories.add(CheckBoxModal(
                id: item['id'],
                title: item['name'],
                count: item['store_count'].toString(),
                image: item['image'].toString(),
                color: item['color'].toString()));
          });
          emit(CategoriesSuccessState(categories));
        }
      },
    );
  }

  /// get Coupon Types
  void getCouponsTypes() {
    emit(CouponTypesLoadingState());
    repository.getCouponTypes().then(
      (value) {
        if (value.errorMessages != null) {
          emit(CouponTypesErrorState(value.errorMessages!));
        } else {
          debugPrint('--------------------------------');
          List<CheckBoxModal> couponTypes = [];

          value.data.forEach((item) {
            couponTypes.add(CheckBoxModal(
              id: item['id'],
              title: item['name'],
              count: item['store_count'].toString(),
            ));
          });
          emit(CouponTypesSuccessState(couponTypes));
        }
      },
    );
  }
}
