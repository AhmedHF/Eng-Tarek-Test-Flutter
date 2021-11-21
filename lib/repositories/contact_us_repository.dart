import 'package:value_client/data_sources/index.dart';
import 'package:value_client/interfaces/index.dart';
import 'package:value_client/models/index.dart';

class ContactUsRepository implements ContactUsInterface {
  final ContactUsDataProvider contactUsDataProvider;
  const ContactUsRepository(this.contactUsDataProvider);
  @override
  Future<AppResponse> sendContactUs(values) {
    return contactUsDataProvider.sendContactUs(values);
  }
}
