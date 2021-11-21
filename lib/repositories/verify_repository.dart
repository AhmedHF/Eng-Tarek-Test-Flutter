import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class VerifyRepository implements VerifyInterface {
  final VerifyDataProvider verifyDataProvider;
  const VerifyRepository(this.verifyDataProvider);
  @override
  Future<AppResponse> verifyCode(values, token) {
    return verifyDataProvider.verifyCode(values, token);
  }
}
