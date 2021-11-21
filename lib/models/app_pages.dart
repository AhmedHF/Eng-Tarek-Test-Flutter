import 'package:value_client/entities/index.dart';

class AppPagesModel extends AppPages {
  const AppPagesModel({
    required int id,
    required String index,
    required String name,
    required String value,
  }) : super(id: id, index: index, name: name, value: value);
  factory AppPagesModel.fromJson(Map<String, dynamic> json) {
    return AppPagesModel(
      id: json['id'],
      index: json['index'],
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'index': index,
        'name': name,
        'value': value,
      };

  @override
  String toString() => 'id: $id index: $index name: $name value: $value';
}
