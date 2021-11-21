import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class UpdateProfileRepository implements UpdateProfileInterface {
  final UpdateProfileProvider updateProfileProvider;
  const UpdateProfileRepository(this.updateProfileProvider);
  @override
  Future<AppResponse> updateProfile(values) {
    return updateProfileProvider.updateProfile(values);
  }
}
