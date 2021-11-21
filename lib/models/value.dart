import 'package:value_client/entities/value.dart';

class ValueModel extends Value {
  const ValueModel({
    required String id,
    required String count,
    required String price,
    required String offer,
  }) : super(id: id, count: count, price: price, offer: offer);

  factory ValueModel.fromJson(Map<String, dynamic> json) {
    return ValueModel(
      id: json['id'],
      count: json['count'],
      price: json['price'],
      offer: json['offer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'count': count,
        'price': price,
        'offer': offer,
      };

  @override
  String toString() => 'id: $id count: $count price: $price offer: $offer';
}
