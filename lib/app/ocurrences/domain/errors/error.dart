import '../../../auth/domain/errors/errors.dart';

class OccurrenceError extends Failure {
  @override
  final String message;
  OccurrenceError({required this.message});
}
