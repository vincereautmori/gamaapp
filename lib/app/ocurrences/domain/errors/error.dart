import '../../../auth/domain/errors/errors.dart';

class OcurrencyError extends Failure {
  @override
  final String message;
  OcurrencyError({required this.message});
}
