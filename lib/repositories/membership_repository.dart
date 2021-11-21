import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class MembershipRepository implements MembershipInterface {
  final MembershipDataProvider membershipDataProvider;
  const MembershipRepository(this.membershipDataProvider);

  @override
  Future<AppResponse> getMemberships() {
    return membershipDataProvider.getMemberships();
  }

  @override
  Future<AppResponse> checkout(data) {
    return membershipDataProvider.checkout(data);
  }
}
