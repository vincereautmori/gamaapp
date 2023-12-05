import 'package:gamaapp/app/profile/presenter/states/profile_states.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../../domain/entities/profile_info.dart';
import '../../domain/usecases/get_profile/get_profile_usecase.dart';
import '../../domain/usecases/set_profile/set_profile_usecase.dart';

class ProfileController extends GetxController {
  final SetProfileUsecase setProfile;
  final GetProfileUsecase getProfile;

  @override
  void onReady() {
    loadProfile();
    super.onReady();
  }

  ProfileInfo? get profile => ProfileStates.profile.value;
  set profile(ProfileInfo? info) => ProfileStates.profile.value = info;

  bool get isCop => profile?.role == "Cop";

  Map<String, String> roleTranslation = {
    "Citizen": "Cidadão",
    "Cop": "Oficial",
    "Admin": "Administrador",
  };

  String? get roleName => roleTranslation[profile?.role];

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

  ProfileController({required this.setProfile, required this.getProfile});
}
