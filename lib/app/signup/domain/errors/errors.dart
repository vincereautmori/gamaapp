import '../../../auth/domain/errors/errors.dart';

class SignUpError extends Failure {
  @override
  final String message;
  SignUpError({required this.message});
}
