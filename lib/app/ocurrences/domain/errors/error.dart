import '../../../auth/domain/errors/errors.dart';

class OcurrenceError extends Failure {
  @override
  final String message;
  OcurrenceError({required this.message});
}
