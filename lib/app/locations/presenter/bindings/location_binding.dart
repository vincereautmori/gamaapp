import 'package:gamaapp/app/locations/domain/usecases/get_position/get_position_usecase.dart';
import 'package:gamaapp/app/locations/domain/usecases/get_position/get_position_usecase_imp.dart';
import 'package:gamaapp/app/locations/infra/datasources/location_datasource.dart';
import 'package:gamaapp/app/locations/infra/repositories/location_repository_imp.dart';
import 'package:gamaapp/app/locations/presenter/controllers/location_controller.dart';
import 'package:get/get.dart';

import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/get_place/get_place_usecase.dart';
import '../../domain/usecases/get_place/get_place_usecase_imp.dart';
import '../../external/datasources/location_datasource_imp.dart';

class LocationBinding implements Bindings {
  @override
  void dependencies() {
    LocationDatasource datasource = LocationDatasourceImp();

    LocationRepository repository = LocationRepositoryImp(datasource);

    GetPositionUsecase getPosition = GetPositionUsecaseImp(repository);
    GetPlaceUsecase getPlace = GetPlaceUsecaseImp(repository);

    Get.lazyPut(
      () => LocationController(
        getPosition: getPosition,
        getPlace: getPlace,
      ),
      fenix: true,
    );
  }
}
