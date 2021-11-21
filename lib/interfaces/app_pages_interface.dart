import 'package:value_client/models/index.dart';

abstract class AppPagesInterface {
  Future<AppResponse> getPageData(String url);
}
