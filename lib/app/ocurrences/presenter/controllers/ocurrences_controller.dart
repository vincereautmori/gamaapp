import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/ocurrency_input.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
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
import '../../domain/entities/ocurrences/ocurrences_list_info.dart';
import '../../domain/entities/properties/properties_info.dart';
import '../../domain/usecases/create_occurrence/create_occurrence_usecase.dart';
import '../../domain/usecases/load_occurrence_data/load_occurrence_data_usecase.dart';
import '../../domain/usecases/stop_occurrence/stop_occurrence_usecase.dart';
import '../states/ocurrences_states.dart';
import '/app/ocurrences/domain/usecases/start_occurrence/start_occurrence_usecase.dart';
import '/app/routes/routes_name.dart';

class OcurrencesController extends GetxController with Loading {
  final StartOccurrenceUsecase startOccurrence;
  final StopOccurrenceUsecase stopOccurrence;
  final CreateOccurrenceUsecase createOccurrence;
  final LoadOccurrenceDataUsecase loadOccurrenceData;

  late CameraController cameraController;

  OcurrencesController({
    required this.startOccurrence,
    required this.stopOccurrence,
    required this.createOccurrence,
    required this.loadOccurrenceData,
  });

  List<OccurrencesListInfo> get occurrences => OccurrenceStates.ocurrences;

  OccurrencesInfo? get openedOccurrence =>
      OccurrenceStates.openedOcurrence.value;

  OccurrencesInfo? get startedOccurrence =>
      OccurrenceStates.startedOccurrence.value;

  int get imageBytesCount => OccurrenceStates.trafficFineImageBytesCount.value;

  int get imageBytesTotal => OccurrenceStates.trafficFineImageBytesTotal.value;

  List<int> get loadedImage => OccurrenceStates.loadedImage;

  OccurrenceInput get occurrenceInput => OccurrenceStates.occurrenceInput.value;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

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
    title.addListener(() {
      setOccurrenceTitle(title.text);
    });
    description.addListener(() {
      setOccurrenceDescription(description.text);
    });
  }

  Future<void> loadImage(String url) async {
    Result<List<int>, Failure> result = await cameraController.loadFile(url);
    return result.when((fileBytes) {
      OccurrenceStates.loadedImage.addAll(fileBytes);
    }, (error) {
      utils.callSnackBar(
          title: "Falha ao carregar imagem", message: error.message);
    });
  }

  Future<void> uploadImage() async {
    setLoading(LoadingStates.uploadingOccurrenceImage);
    Result<XFile?, Failure> result = await cameraController.getFileFromCamera();
    result.when(
      (file) async {
        if (file != null) {
          dio_package.FormData? formData = await file.toFormData('fileName');
          Result uploadResult = await cameraController.uploadFile(formData!,
              onSendProgress: (count, total) {
            OccurrenceStates.trafficFineImageBytesCount.value = count;
            OccurrenceStates.trafficFineImageBytesTotal.value = total;
          });
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

  void clearOccurrenceData() {
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
    loadedImage.clear();
    OccurrenceStates.trafficFineImageBytesCount.value = 0;
    title.clear();
    description.clear();
  }

  void setOccurrenceLocation() {
    Placemark? place = LocationStates.place.value;
    Position? position = LocationStates.position.value;

    OccurrenceStates.occurrenceInput.value = occurrenceInput.copyWith(
      latitude: position?.latitude ?? 0,
      longitude: position?.longitude ?? 0,
      location: place?.street ?? "",
    );
  }

  void fillOccurrences(List<OccurrencesListInfo> occurrences) {
    OccurrenceStates.ocurrences.value = occurrences;
  }

  void notifyNewOccurrence(OccurrencesListInfo newOccurrence) {
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

  void viewOccurrence(int id) async {
    Result<OccurrencesInfo, Failure> result = await loadOccurrenceData(id);

    result.when((ocurrence) {
      OccurrenceStates.openedOcurrence.value = ocurrence;
      Get.toNamed(RoutesNames.viewOccurrence);
    }, (error) => print(error));
  }

  void refreshOccurrence(int id) async {
    Result<OccurrencesInfo, Failure> result = await loadOccurrenceData(id);

    result.when((ocurrence) {
      OccurrenceStates.openedOcurrence.value = ocurrence;
    }, (error) => print(error));
  }

  void removeCompletedOccurrence(int id) {
    occurrences.removeWhere((occurrence) => occurrence.occurrenceId == id);
  }

  void start(OccurrencesInfo occurrence) async {
    Result result = await startOccurrence(occurrence.id);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = occurrence;
      utils.callSnackBar(
        title: "Iniciado ocorrência",
        message: "Ocorrência ${occurrence.id} iniciada com sucesso",
      );
      refreshOccurrence(occurrence.id);
    },
        (error) => utils.callSnackBar(
              title: "Falha ao iniciar ocorrência",
              message: error.message,
            ));
  }

  void stop(int id) async {
    Result result = await stopOccurrence(id);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = null;
      utils.callSnackBar(
        title: "Ocorrência finalizada",
        message: "Ocorrência $id finalizada com sucesso",
      );
      removeCompletedOccurrence(id);
      refreshOccurrence(id);
    },
        (error) => utils.callSnackBar(
              title: "Falha ao finalizar ocorrência",
              message: error.message,
            ));
  }

  void newOccurrence() async {
    setLoading(LoadingStates.createOccurrence);

    setOccurrenceLocation();
    Result<Unit, Failure> result = await createOccurrence(
      occurrenceInput,
    );
    stopLoading();
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
