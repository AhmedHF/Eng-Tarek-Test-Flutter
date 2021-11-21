import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class ResetPasswordRepository implements ResetPasswordInterface {
  final ResetPasswordDataProvider resetPasswordDataProvider;
  const ResetPasswordRepository(this.resetPasswordDataProvider);
  @override
  Future<AppResponse> resetPassword(values) {
    return resetPasswordDataProvider.resetPassword(values);
  }
}
