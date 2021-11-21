import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class ForgetPasswordRepository implements ForgetPasswordInterface {
  final ForgetPasswordDataProvider forgetPasswordDataProvider;
  const ForgetPasswordRepository(this.forgetPasswordDataProvider);
  @override
  Future<AppResponse> forgetPassword(values) {
    return forgetPasswordDataProvider.forgetPassword(values);
  }
}
