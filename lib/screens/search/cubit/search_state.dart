part of 'search_cubit.dart';

abstract class SearchStates extends Equatable {
  const SearchStates();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchStates {}

// categories
class CategoriesLoadingState extends SearchStates {}

class CategoriesSuccessState extends SearchStates {
  final List<CheckBoxModal> categories;
  CategoriesSuccessState(this.categories);
}

class CategoriesErrorState extends SearchStates {
  final String error;
  CategoriesErrorState(this.error);
}

// CouponTypes
class CouponTypesLoadingState extends SearchStates {}

class CouponTypesSuccessState extends SearchStates {
  final List<CheckBoxModal> couponTypes;
  CouponTypesSuccessState(this.couponTypes);
}

class CouponTypesErrorState extends SearchStates {
  final String error;
  CouponTypesErrorState(this.error);
}

class ChangeMyValuesSortType extends SearchStates {
  final SortByDateType type;
  ChangeMyValuesSortType(this.type);
}
