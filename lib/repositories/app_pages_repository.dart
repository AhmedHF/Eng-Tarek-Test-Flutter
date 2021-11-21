import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class AppPagesRepository implements AppPagesInterface {
  final AppPagesDataProvider appPagesDataProvider;
  const AppPagesRepository(this.appPagesDataProvider);
  @override
  Future<AppResponse> getPageData(url) {
    return appPagesDataProvider.getPageData(url);
  }
}
