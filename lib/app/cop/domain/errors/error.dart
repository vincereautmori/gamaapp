import '../../../auth/domain/errors/errors.dart';

class TrafficFineError extends Failure {
  @override
  final String message;
  TrafficFineError({required this.message});
}

class TrafficViolationError extends Failure {
  @override
  final String message;
  TrafficViolationError({required this.message});
}
