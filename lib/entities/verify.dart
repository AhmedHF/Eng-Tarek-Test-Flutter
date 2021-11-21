import 'package:equatable/equatable.dart';

class Verify extends Equatable {
  final String phone;
  final String code;

  const Verify({
    required this.phone,
    required this.code,
  });

  @override
  List<Object?> get props => [phone, code];
}
