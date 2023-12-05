import 'package:flutter/material.dart';
import 'package:gamaapp/app/profile/presenter/states/profile_states.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/utils/loading.dart';
import '../../../auth/domain/errors/errors.dart';
import '../../domain/entities/profile_info.dart';
import '../../domain/usecases/get_profile/get_profile_usecase.dart';
import '../../domain/usecases/set_profile/set_profile_usecase.dart';
import '../../domain/usecases/update_password/update_password_usecase.dart';

class ProfileController extends GetxController with Loading {
  final SetProfileUsecase setProfile;
  final GetProfileUsecase getProfile;
  final UpdatePasswordUsecase updatePassword;

  @override
  void onReady() {
    loadProfile();
    super.onReady();
  }

  ProfileInfo? get profile => ProfileStates.profile.value;
  set profile(ProfileInfo? info) => ProfileStates.profile.value = info;

  bool get isCop => profile?.role == "Cop";

  bool get isLoading => loadingState.value == LoadingStates.updatePassword;

  Map<String, String> roleTranslation = {
    "Citizen": "Cidadão",
    "Cop": "Oficial",
    "Admin": "Administrador",
  };

  String? get roleName => roleTranslation[profile?.role];

  TextEditingController newPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  void loadProfile() async {
    Result<ProfileInfo?, Failure> result = await getProfile();

    result.when(
      (success) => profile = success,
      (error) => utils.callSnackBar(
        title: "Falha ao carregar dados do usuário",
        message: error.message,
      ),
    );
  }

  void handleUpdatePassword() async {
    setLoading(LoadingStates.updatePassword);
    Result result = await updatePassword(
      profile?.username ?? "",
      newPassword: newPassword.text,
      oldPassword: oldPassword.text,
    );

    result.when(
      (success) {
        utils.callSnackBar(
          title: "Senha alterada com Sucesso!",
          message: "Utilize sua nova senha ao acessar o sistema novamente",
          snackStyle: SnackBarStyles.success,
        );
        newPassword.clear();
        oldPassword.clear();
      },
      (error) => utils.callSnackBar(
        title: "Falha ao alterar a senha",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
    stopLoading();
  }

  ProfileController({
    required this.setProfile,
    required this.getProfile,
    required this.updatePassword,
  });
}
