import 'package:value_client/models/index.dart';

abstract class ContactUsInterface {
  Future<AppResponse> sendContactUs(values);
}
