import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final String phone;
  final String code;
  final String newPassword;
  final String newPasswordConfirmation;

  const ResetPassword({
    required this.phone,
    required this.code,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  @override
  List<Object?> get props => [phone];
}
