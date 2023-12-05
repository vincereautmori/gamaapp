import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile/get_profile_usecase.dart';
import '../../domain/usecases/get_profile/get_profile_usecase_imp.dart';
import '../../domain/usecases/set_profile/set_profile_usecase.dart';
import '../../domain/usecases/set_profile/set_profile_usecase_imp.dart';
import '../../external/datasources/profile_datasource_imp.dart';
import '../../external/hive/profile_hive.dart';
import '../../infra/datasources/profile_datasource.dart';
import '../../infra/repositories/profile_repository_imp.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Box<ProfileHive> box = Hive.box("profile");

    ProfileDatasource datasource = ProfileDatasourceImp(box);

    ProfileRepository repository = ProfileRepositoryImp(datasource);

    GetProfileUsecase getProfile = GetProfileUsecaseImp(repository);
    SetProfileUsecase setProfile = SetProfileUsecaseImp(repository);
    Get.lazyPut(
      () => ProfileController(
        getProfile: getProfile,
        setProfile: setProfile,
      ),
      fenix: true,
    );
  }
}
