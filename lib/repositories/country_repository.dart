
import 'package:flutter/foundation.dart';
import 'package:value_client/core/helpers/index.dart';
import 'package:value_client/models/country.dart';

class CounrtyRepository {
  static String initCounrty() {
    String? countryId = StorageHelper.getData(key: 'countryId');
    debugPrint('COUNTRY ==> : ${countryId.toString()}', wrapWidth: 1024);

    return countryId ?? '';
  }

  static void setCountry(CountryModel country) {
    StorageHelper.saveObject(key: 'country', object: country);
  }
}
