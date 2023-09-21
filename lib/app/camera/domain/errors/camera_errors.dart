import '../../../auth/domain/errors/errors.dart';

class CameraError extends Failure {
  @override
  final String message;
  CameraError({required this.message});
}
