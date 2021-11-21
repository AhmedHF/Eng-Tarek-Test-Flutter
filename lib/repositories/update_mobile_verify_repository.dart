import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class UpdateMobileVerifyRepository implements UpdateMobileVerifyInterface {
  final UpdateMobileVerifyProvider updateMobileVerifyDataProvider;
  const UpdateMobileVerifyRepository(this.updateMobileVerifyDataProvider);
  @override
  Future<AppResponse> updateMobileVerify(values) {
    return updateMobileVerifyDataProvider.updateMobileVerify(values);
  }
}
