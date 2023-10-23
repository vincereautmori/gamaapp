import '../../../auth/domain/errors/errors.dart';

class LocationPermissionError extends Failure {
  @override
  final String message;
  LocationPermissionError({required this.message});
}

class LocationEnabledError extends Failure {
  @override
  final String message;
  LocationEnabledError({required this.message});
}

class DecodingLocationError extends Failure {
  @override
  final String message;
  DecodingLocationError({required this.message});
}

class InvalidLocationError extends Failure {
  @override
  final String message;
  InvalidLocationError({required this.message});
}
