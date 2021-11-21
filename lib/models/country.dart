import 'package:value_client/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required int id,
    required String name,
    required String code,
  }) : super(
          id: id,
          name: name,
          code: code,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
      };

  @override
  String toString() => 'id: $id name: $name code: $code';
}
