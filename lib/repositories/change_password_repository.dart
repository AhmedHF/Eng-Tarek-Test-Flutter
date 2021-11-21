import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class ChangePasswordRepository implements ChangePasswordInterface {
  final ChangePasswordDataProvider changePasswordDataProvider;
  const ChangePasswordRepository(this.changePasswordDataProvider);
  @override
  Future<AppResponse> changePassword(values) {
    return changePasswordDataProvider.changePassword(values);
  }
}
