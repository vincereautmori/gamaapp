import 'package:gamaapp/app/profile/domain/errors/errors.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../repositories/profile_repository.dart';
import 'update_password_usecase.dart';

class UpdatePasswordUsecaseImp implements UpdatePasswordUsecase {
  final ProfileRepository repository;

  UpdatePasswordUsecaseImp(this.repository);

  @override
  Future<Result<Unit, Failure>> call(
    String login, {
    required String oldPassword,
    required String newPassword,
  }) async {
    if (oldPassword == newPassword) {
      return Error(
          ProfileError(message: "A nova senha não pode ser igual a anterior"));
    }

    return repository.updatePassword(
      login,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
