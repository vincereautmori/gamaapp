import 'package:flutter/material.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';
import '/app/cop/presenter/states/traffic_fine_states.dart';
import '../../domain/entities/dtos/traffic_fine_filter_dto.dart';
import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';

class CopTrafficFineController extends GetxController {
  final GetTrafficFineUsecase getTrafficFines;

  CopTrafficFineController(this.getTrafficFines);

  List<ListedTrafficFineInfo> get trafficFines =>
      TrafficFineStates.trafficFines;

  TextEditingController get createdSince =>
      TrafficFineStates.createdSince.value;
  TextEditingController get createdUntil =>
      TrafficFineStates.createdUntil.value;

  @override
  void onInit() {
    super.onInit();
    fetchAllTrafficFines();
  }

  Future<void> fetchAllTrafficFines() async {
    DateTime? since = createdSince.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdSince.text)
        : null;
    DateTime? until = createdUntil.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdUntil.text)
        : null;
    Result result = await getTrafficFines(
      TrafficFineFilterDto(
        createdSince: since,
        createdUntil: until,
      ),
    );

    result.when(
      (success) => TrafficFineStates.trafficFines.value = success,
      (error) => utils.callSnackBar(
        title: "Falha ao carregar multas",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }
}
