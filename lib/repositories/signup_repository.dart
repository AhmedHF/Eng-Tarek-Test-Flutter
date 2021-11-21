import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class SignupRepository implements SignupInterface {
  final SignupDataProvider signupDataProvider;
  const SignupRepository(this.signupDataProvider);
  @override
  Future<AppResponse> signup(values) {
    return signupDataProvider.signup(values);
  }
}
