import '../../../auth/domain/errors/errors.dart';

class ProfileError extends Failure {
  @override
  final String message;
  ProfileError({required this.message});
}
