import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class ResendRepository implements ResendInterface {
  final ResendDataProvider resendDataProvider;
  const ResendRepository(this.resendDataProvider);
  @override
  Future<AppResponse> resendCode(values) {
    return resendDataProvider.resendCode(values);
  }
}
