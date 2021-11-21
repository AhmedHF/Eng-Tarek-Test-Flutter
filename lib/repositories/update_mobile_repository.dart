import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class UpdateMobileRepository implements UpdateMobileInterface {
  final UpdateMobileDataProvider updateMobileDataProvider;
  const UpdateMobileRepository(this.updateMobileDataProvider);
  @override
  Future<AppResponse> updateMobile(values) {
    return updateMobileDataProvider.updateMobile(values);
  }
}
