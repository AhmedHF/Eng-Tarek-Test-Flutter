import 'package:equatable/equatable.dart';

class ComplainTypeModel extends Equatable {
  final String id;
  final String value;
  final String label;

  const ComplainTypeModel({
    required this.id,
    required this.value,
    required this.label,
  });

  @override
  String toString() => 'id: $id value: $value label: $label';

  @override
  List<Object?> get props => [id, value, label];
}
