import 'package:dio/dio.dart' as dio_package;
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/ocurrency_input.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/themes/snackbar_styles.dart';
import '../../../../shared/utils/loading.dart';
import '../../../auth/domain/errors/errors.dart';
import '../../../camera/presenter/controllers/camera_controller.dart';
import '../../../locations/presenter/states/location_states.dart';
import '../../domain/entities/properties/properties_info.dart';
import '../../domain/usecases/create_occurrence/create_occurrence_usecase.dart';
import '../../domain/usecases/stop_occurrence/stop_occurrence_usecase.dart';
import '../states/ocurrences_states.dart';
import '/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import '/app/ocurrences/domain/usecases/start_occurrence/start_occurrence_usecase.dart';
import '/app/routes/routes_name.dart';

class OcurrencesController extends GetxController with Loading {
  final StartOccurrenceUsecase startOccurrence;
  final StopOccurrenceUsecase stopOccurrence;
  final CreateOccurrenceUsecase createOccurrence;

  late CameraController cameraController;

  //TODO remover o método uploadImage e loadImage daqui e abstrair para um módulo correto
  late CopTrafficFineController fileController;

  OcurrencesController({
    required this.startOccurrence,
    required this.stopOccurrence,
    required this.createOccurrence,
  });

  List<OccurrencesInfo> get occurrences => OccurrenceStates.ocurrences;

  OccurrencesInfo? get openedOccurrence =>
      OccurrenceStates.openedOcurrence.value;

  OccurrencesInfo? get startedOccurrence =>
      OccurrenceStates.startedOccurrence.value;

  int get imageBytesCount => OccurrenceStates.trafficFineImageBytesCount.value;
  int get imageBytesTotal => OccurrenceStates.trafficFineImageBytesTotal.value;

  List<int> get loadedImage => OccurrenceStates.loadedImage;

  OccurrenceInput get occurrenceInput => OccurrenceStates.occurrenceInput.value;

  List<PropertiesInfo> get occurrenceTypes =>
      OccurrenceStates.occurrenceTypes.value;

  bool get isCreateLoading =>
      loadingState.value == LoadingStates.createOccurrence;

  bool get isUploading =>
      loadingState.value == LoadingStates.uploadingOccurrenceImage;

  @override
  void onInit() {
    super.onInit();
    cameraController = Get.find<CameraController>();
    fileController = Get.find<CopTrafficFineController>();
  }

  Future<void> uploadImage() async {
    setLoading(LoadingStates.uploadingOccurrenceImage);
    Result<XFile?, Failure> result = await cameraController.getFileFromCamera();
    result.when(
      (file) async {
        if (file != null) {
          dio_package.FormData? formData = await file.toFormData('fileName');
          Result uploadResult = await fileController.uploadFile(formData!);
          stopLoading();
          String url = uploadResult.tryGetSuccess();

          setFileUrl(url);
          OccurrenceStates.loadedImage.clear();
          OccurrenceStates.loadedImage.addAll(await file.readAsBytes());
        } else {
          OccurrenceStates.trafficFineImageBytesCount.value = 0;
        }
      },
      (error) => utils.callSnackBar(
        title: "Falha ao salvar imagem",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }

  void setUrgencyLevel(int id) {
    OccurrenceStates.occurrenceInput.value =
        occurrenceInput.copyWith(occurrenceUrgencyLevelId: id);
  }

  void setFileUrl(String url) {
    OccurrenceStates.occurrenceInput.value =
        occurrenceInput.copyWith(imageUrl: url);
  }

  void setType(int id) {
    OccurrenceStates.occurrenceInput.value =
        occurrenceInput.copyWith(occurrenceTypeId: id);
  }

  void setOccurrenceTitle(String title) {
    OccurrenceStates.occurrenceInput.value =
        occurrenceInput.copyWith(name: title);
  }

  void setOccurrenceDescription(String description) {
    OccurrenceStates.occurrenceInput.value =
        occurrenceInput.copyWith(description: description);
  }

  void clearOccurrenceData() =>
      OccurrenceStates.occurrenceInput.value = OccurrenceInput(
        latitude: -22.7704398,
        longitude: -47.3310491,
        location: "",
        name: "",
        description: "",
        occurrenceStatusId: 1,
        occurrenceUrgencyLevelId: 1,
        occurrenceTypeId: 1,
        imageUrl: "",
      );

  void setOccurrenceLocation() {
    Placemark? place = LocationStates.place.value;
    Position? position = LocationStates.position.value;

    OccurrenceStates.occurrenceInput.value = occurrenceInput.copyWith(
      latitude: position?.latitude ?? 0,
      longitude: position?.longitude ?? 0,
      location: place?.street ?? "",
    );
  }

  void fillOccurrences(List<OccurrencesInfo> occurrences) {
    OccurrenceStates.ocurrences.value = occurrences;
  }

  void notifyNewOccurrence(OccurrencesInfo newOccurrence) {
    bool ocurrenceAlreadyExist = occurrences.any(
      (ocurrence) => ocurrence.occurrenceId == newOccurrence.occurrenceId,
    );

    if (!ocurrenceAlreadyExist) {
      occurrences.add(newOccurrence);

      utils.callSnackBar(
        title: "Nova ocorrência cadastrada",
        message:
            "Uma nova ocorrência surgiu em suas proximidades - ${newOccurrence.occurrenceId}",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void viewOccurrence(OccurrencesInfo ocurrence) {
    OccurrenceStates.openedOcurrence.value = ocurrence;
    Get.toNamed(RoutesNames.viewOccurrence);
  }

  void start(OccurrencesInfo occurrence) async {
    Result result = await startOccurrence(occurrence.occurrenceId);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = occurrence;
      utils.callSnackBar(
        title: "Iniciado ocorrência",
        message: "Ocorrência ${occurrence.occurrenceId} iniciada com sucesso",
      );
    },
        (error) => utils.callSnackBar(
              title: "Falha ao iniciar ocorrência",
              message: error.message,
            ));
  }

  void stop(OccurrencesInfo occurrence) async {
    print("STOP OCCURRENCE ID = ${occurrence.occurrenceId}");
    Result result = await stopOccurrence(occurrence.occurrenceId);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = null;
      utils.callSnackBar(
        title: "Ocorrência finalizada",
        message: "Ocorrência ${occurrence.occurrenceId} finalizada com sucesso",
      );
    },
        (error) => utils.callSnackBar(
              title: "Falha ao finalizar ocorrência",
              message: error.message,
            ));
  }

  void newOccurrence() async {
    setOccurrenceLocation();
    Result<Unit, Failure> result = await createOccurrence(
      occurrenceInput,
    );

    result.when(
      (success) {
        utils.callSnackBar(
          title: "title",
          message: "Ocorrência criada com sucesso!",
        );
        clearOccurrenceData();
      },
      (error) => utils.callSnackBar(
        title: "Erro",
        message: error.message,
      ),
    );
  }
}