import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/utils/loading.dart';
import '../../../routes/routes_name.dart';
import '../../domain/entities/properties/properties_info.dart';
import '../../domain/usecases/get_properties/get_properties_usecase.dart';
import '../states/ocurrences_states.dart';

class OccurrencesPropertiesController extends GetxController with Loading {
  final GetPropertiesUsecase getProperties;

  OccurrencesPropertiesController(this.getProperties);

  bool get isPropertiesLoading =>
      loadingState.value == LoadingStates.occurrenceProperties;

  Future<void> fetchProperties() async {
    Result<OccurrencePropertiesInfo, Failure> result = await getProperties();
    result.when(
      (OccurrencePropertiesInfo properties) {
        OccurrenceStates.occurrenceTypes.value = properties.types;
        Get.toNamed(RoutesNames.newOccurrence);
      },
      (error) => utils.callSnackBar(
        title: "Erro",
        message: error.message,
      ),
    );
  }
}
