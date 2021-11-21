import 'package:equatable/equatable.dart';

class Value extends Equatable {
  final String id;
  final String count;
  final String price;
  final String offer;

  const Value({
    required this.id,
    required this.count,
    required this.price,
    required this.offer,
  });

  @override
  List<Object?> get props => [id, count, price, offer];
}
