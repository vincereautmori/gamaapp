import '../../../auth/domain/errors/errors.dart';

class TrafficFineError extends Failure {
  @override
  final String message;
  TrafficFineError({required this.message});
}

class UploadImageError extends Failure {
  @override
  final String message;
  UploadImageError({required this.message});
}
