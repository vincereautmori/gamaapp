import '../../../auth/domain/errors/errors.dart';

class TrafficFineError extends Failure {
  @override
  final String message;
  TrafficFineError({required this.message});
}
