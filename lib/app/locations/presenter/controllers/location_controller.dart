import 'package:gamaapp/app/locations/domain/usecases/get_place/get_place_usecase.dart';
import 'package:gamaapp/app/locations/domain/usecases/get_position/get_position_usecase.dart';
import 'package:gamaapp/app/locations/presenter/states/location_states.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

class LocationController extends GetxController {
  final GetPositionUsecase getPosition;
  final GetPlaceUsecase getPlace;

  LocationController({required this.getPosition, required this.getPlace});

  Placemark? get place => LocationStates.place.value;

  @override
  void onInit() async {
    super.onInit();
    await determinePlace();
  }

  Future<void> determinePlace() async {
    Result result = await getPosition();
    result.when((position) {
      LocationStates.position.value = position;
      getPlace(position).then(
        (value) => value.when(
          (Placemark place) => LocationStates.place.value = place,
          (err) => utils.callSnackBar(
            title: 'Falha ao recuperar sua localização',
            message: err.message,
          ),
        ),
      );
    }, (err) {
      utils.callSnackBar(
        title: 'Falha ao recuperar sua localização',
        message: err.message,
      );
    });
  }
}
