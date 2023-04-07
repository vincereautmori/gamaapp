import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../shared/config/config.dart';
import 'login/domain/repositories/authentication_repository.dart';
import 'login/domain/usecases/signIn/sign_in_usecase.dart';
import 'login/domain/usecases/signIn/sign_in_usecase_imp.dart';
import 'login/external/datasources/authentication_datasource_imp.dart';
import 'login/infra/datasources/authentication_datasource.dart';
import 'login/infra/repositories/authentication_repository.dart';
import 'login/presenter/controllers/sign_in_controller.dart';

class MainBind extends Bindings {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: Config.coreApiUrl),
  );

  @override
  void dependencies() {
    AuthenticationDatasource dataSource = AuthenticationDatasourceImp(_dio);
    AuthenticationRepository repository =
        AuthenticationRepositoryImp(dataSource);
    SignInUseCase useCase = SignInUseCaseImp(repository: repository);

    Get.put(SignInController(useCase));
  }
}
