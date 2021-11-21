import 'package:equatable/equatable.dart';

class ForgetPassword extends Equatable {
  final String phone;

  const ForgetPassword({
    required this.phone,
  });

  @override
  List<Object?> get props => [phone];
}
