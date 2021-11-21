import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class SearchRepository implements SearchInterface {
  final SearchDataProvider searchDataProvider;
  const SearchRepository(this.searchDataProvider);

  @override
  Future<AppResponse> getCategories() {
    return searchDataProvider.getCategories();
  }

  @override
  Future<AppResponse> getCouponTypes() {
    return searchDataProvider.getCouponTypes();
  }
}
