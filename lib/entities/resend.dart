import 'package:equatable/equatable.dart';

class Resend extends Equatable {
  final String phone;

  const Resend({
    required this.phone,
  });

  @override
  List<Object?> get props => [phone];
}
