import 'package:equatable/equatable.dart';

class AppPages extends Equatable {
  final int id;
  final String index;
  final String name;
  final String value;

  const AppPages({
    required this.id,
    required this.index,
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [id, index, name, value];
}
