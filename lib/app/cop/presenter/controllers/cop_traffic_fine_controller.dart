import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/cop/domain/entities/dtos/traffic_fine_input_dto.dart';
import 'package:gamaapp/app/cop/domain/usecases/saveTrafficFine/save_traffic_usecase.dart';
import 'package:gamaapp/app/cop/domain/usecases/uploadFile/upload_file_usecase.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';
import '/app/cop/presenter/states/traffic_fine_states.dart';
import '../../../camera/presenter/controllers/camera_controller.dart';
import '../../domain/entities/dtos/traffic_fine_filter_dto.dart';
import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';

class CopTrafficFineController extends GetxController {
  final GetTrafficFineUsecase getTrafficFines;
  final SaveTrafficUsecase saveTrafficFine;
  final UploadFileUsecase uploadFile;

  late CameraController cameraController;

  CopTrafficFineController({
    required this.getTrafficFines,
    required this.saveTrafficFine,
    required this.uploadFile,
  });

  List<ListedTrafficFineInfo> get trafficFines =>
      TrafficFineStates.trafficFines;

  TextEditingController get createdSince =>
      TrafficFineStates.createdSince.value;
  TextEditingController get createdUntil =>
      TrafficFineStates.createdUntil.value;

  @override
  void onInit() {
    super.onInit();
    cameraController = Get.find<CameraController>();

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

  Future<void> uploadImage() async {
    Result<XFile?, Failure> result = await cameraController.getFileFromCamera();
    result.when((file) async {
      if (file != null) {
        Dio.FormData? formData = await file.toFormData('fileName');
        Result uploadResult = await uploadFile(formData!);
        var bla = uploadResult.tryGetSuccess();
        print(bla);
      }
    }, (error) => null);
  }

  Future<void> addTrafficFine() async {
    Result result = await saveTrafficFine(
      TrafficFineInputDto(
        licensePlate: 'EAH6B88',
        latitude: 41.1425,
        longitude: -41.1425,
        trafficViolations: [
          {"id": 1}
        ],
        imageUrl: "",
      ),
    );

    result.when(
      (success) => utils.callSnackBar(
        title: "Multa salva com sucesso",
        message: "Multa salva com sucesso",
        snackStyle: SnackBarStyles.error,
      ),
      (error) => utils.callSnackBar(
        title: "Falha ao salvar multas",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }
}
