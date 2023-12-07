import 'package:dio/dio.dart' as dio_package;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/occurrence_filter_dto.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/dtos/occurrence_input.dart';
import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/dtos/pagination_dto.dart';
import '../../../../shared/themes/snackbar_styles.dart';
import '../../../../shared/utils/loading.dart';
import '../../../auth/domain/errors/errors.dart';
import '../../../camera/presenter/controllers/camera_controller.dart';
import '../../../locations/presenter/states/location_states.dart';
import '../../domain/entities/ocurrences/listed_occurrences_info.dart';
import '../../domain/entities/ocurrences/occurrences_map_info.dart';
import '../../domain/entities/properties/properties_info.dart';
import '../../domain/usecases/create_occurrence/create_occurrence_usecase.dart';
import '../../domain/usecases/get_paginated_occurrences/get_paginated_occurrences_usecase.dart';
import '../../domain/usecases/load_occurrence_data/load_occurrence_data_usecase.dart';
import '../../domain/usecases/stop_occurrence/stop_occurrence_usecase.dart';
import '../states/ocurrences_states.dart';
import '/app/ocurrences/domain/usecases/start_occurrence/start_occurrence_usecase.dart';
import '/app/routes/routes_name.dart';

class OccurrencesController extends GetxController with Loading {
  final StartOccurrenceUsecase startOccurrence;
  final StopOccurrenceUsecase stopOccurrence;
  final CreateOccurrenceUsecase createOccurrence;
  final LoadOccurrenceDataUsecase loadOccurrenceData;
  final GetPaginatedOccurrencesUsecase getPaginatedOccurrences;

  late CameraController cameraController;

  late ScrollController scroll;

  OccurrencesController({
    required this.startOccurrence,
    required this.stopOccurrence,
    required this.createOccurrence,
    required this.loadOccurrenceData,
    required this.getPaginatedOccurrences,
  });

  List<OccurrencesMapInfo> get mapOccurrences => OccurrenceStates.mapOcurrences;

  List<ListedOccurrencesInfo> get occurrences => OccurrenceStates.occurrences;

  bool get hideAddButton =>
      OccurrenceStates.scrollDirection.value == ScrollDirection.reverse;

  OccurrencesInfo? get openedOccurrence =>
      OccurrenceStates.openedOcurrence.value;

  OccurrencesInfo? get startedOccurrence =>
      OccurrenceStates.startedOccurrence.value;

  int get imageBytesCount => OccurrenceStates.trafficFineImageBytesCount.value;

  int get imageBytesTotal => OccurrenceStates.trafficFineImageBytesTotal.value;

  List<int> get loadedImage => OccurrenceStates.loadedImage;

  OccurrenceInput get occurrenceInput => OccurrenceStates.occurrenceInput.value;

  PaginationDto get pagination => OccurrenceStates.pagination.value;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  List<PropertiesInfo> get occurrenceTypes =>
      OccurrenceStates.occurrenceTypes.value;

  TextEditingController get createdSince => OccurrenceStates.createdSince.value;

  TextEditingController get createdUntil => OccurrenceStates.createdUntil.value;

  bool get isOccurrencesLoading =>
      loadingState.value == LoadingStates.occurrences;

  bool get isCreateLoading =>
      loadingState.value == LoadingStates.createOccurrence;

  bool get isUploading =>
      loadingState.value == LoadingStates.uploadingOccurrenceImage;

  bool get isStartingOrIsStoping => [
        LoadingStates.startOccurrence,
        LoadingStates.stopOccurrence
      ].contains(loadingState.value);

  @override
  void onInit() {
    super.onInit();
    scroll = ScrollController();

    cameraController = Get.find<CameraController>();
    if (!scroll.hasClients) {
      scroll.addListener(scrollListener);
    }

    title.addListener(() {
      setOccurrenceTitle(title.text);
    });
    description.addListener(() {
      setOccurrenceDescription(description.text);
    });
  }

  @override
  void onReady() {
    search();
    super.onReady();
  }

  @override
  void onClose() {
    scroll.dispose();
    clearListedOccurrences();
    clearOccurrenceData();

    super.onClose();
  }

  void scrollListener() {
    OccurrenceStates.scrollDirection.value =
        scroll.position.userScrollDirection;

    if (scroll.offset >= scroll.position.maxScrollExtent &&
        !scroll.position.outOfRange) {
      nextPage();
    }
  }

  void nextPage() async {
    OccurrenceStates.pagination.value =
        pagination.copyWith(pageNumber: pagination.pageNumber + 1);

    await fetchAllOccurrences();
  }

  Future<void> fetchAllOccurrences() async {
    if (pagination.count == occurrences.length && occurrences.isNotEmpty) {
      return utils.callSnackBar(
        title: 'Nenhuma ocorrência nova',
        message: "Parece que você carregou todas as ocorrências",
        snackStyle: SnackBarStyles.warning,
      );
    }

    setLoading(LoadingStates.occurrences);

    DateTime? since = createdSince.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdSince.text)
        : null;
    DateTime? until = createdUntil.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdUntil.text)
        : null;

    Result result = await getPaginatedOccurrences(
      OccurrenceFilterDto(
          createdSince: since, createdUntil: until, pagination: pagination),
    );
    stopLoading();
    result.when(
      (occurrences) => handlePaginationResult(occurrences),
      (error) => utils.callSnackBar(
        title: "Falha ao carregar ocorrências",
        message: error.message,
        snackStyle: SnackBarStyles.warning,
      ),
    );
  }

  void clearListedOccurrences() {
    OccurrenceStates.pagination.value =
        pagination.copyWith(pageNumber: 1, count: 0);
    OccurrenceStates.occurrences.clear();
  }

  Future<void> search() async {
    clearListedOccurrences();
    await fetchAllOccurrences();
  }

  void handlePaginationResult(List<ListedOccurrencesInfo> occurrences) {
    if (occurrences.isEmpty) {
      OccurrenceStates.occurrences.value = occurrences;
    }

    if (occurrences.isNotEmpty &&
        pagination.pageNumber >= occurrences.last.pageNumber) {
      OccurrenceStates.occurrences.addAll(occurrences);
    }
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
          uploadResult.when((url) async {
            setFileUrl(url);
            OccurrenceStates.loadedImage.clear();
            OccurrenceStates.loadedImage.addAll(await file.readAsBytes());
          },
              (error) => utils.callSnackBar(
                    title: "Falha ao salvar imagem",
                    message: error.message,
                    snackStyle: SnackBarStyles.error,
                  ));
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

  void fillMapOccurrences(List<OccurrencesMapInfo> occurrences) {
    OccurrenceStates.mapOcurrences.value = occurrences;
  }

  void notifyNewOccurrence(OccurrencesMapInfo newOccurrence) {
    bool ocurrenceAlreadyExist = mapOccurrences.any(
      (ocurrence) => ocurrence.occurrenceId == newOccurrence.occurrenceId,
    );
    if (!ocurrenceAlreadyExist) {
      mapOccurrences.add(newOccurrence);

      utils.callSnackBar(
        title: "Nova ocorrência cadastrada",
        message:
            "Uma nova ocorrência surgiu em suas proximidades - ${newOccurrence.occurrenceId}",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void viewOccurrence(int id) async {
    OccurrenceStates.openedOcurrence.value = null;
    Get.toNamed(RoutesNames.viewOccurrence);
    Result<OccurrencesInfo, Failure> result = await loadOccurrenceData(id);

    result.whenSuccess((ocurrence) {
      OccurrenceStates.openedOcurrence.value = ocurrence;
    });
  }

  void clearOpenedOccurrence() {
    OccurrenceStates.openedOcurrence.value = null;
    loadedImage.clear();
  }

  void refreshOccurrence(int id) async {
    Result<OccurrencesInfo, Failure> result = await loadOccurrenceData(id);

    result.whenSuccess((ocurrence) {
      OccurrenceStates.openedOcurrence.value = ocurrence;
    });
  }

  void removeCompletedOccurrence(int id) {
    mapOccurrences.removeWhere((occurrence) => occurrence.occurrenceId == id);
  }

  void start(OccurrencesInfo occurrence) async {
    setLoading(LoadingStates.startOccurrence);
    Result result = await startOccurrence(occurrence.id);
    result.when(
      (_) {
        OccurrenceStates.startedOccurrence.value = occurrence;
        utils.callSnackBar(
          title: "Iniciado ocorrência",
          message: "Ocorrência ${occurrence.id} iniciada com sucesso",
          snackStyle: SnackBarStyles.success,
        );
        refreshOccurrence(occurrence.id);
      },
      (error) => utils.callSnackBar(
        title: "Falha ao iniciar ocorrência",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
    stopLoading();
  }

  void stop(int id) async {
    setLoading(LoadingStates.startOccurrence);
    Result result = await stopOccurrence(id);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = null;
      utils.callSnackBar(
        title: "Ocorrência finalizada",
        message: "Ocorrência $id finalizada com sucesso",
        snackStyle: SnackBarStyles.success,
      );
      removeCompletedOccurrence(id);
      refreshOccurrence(id);
    },
        (error) => utils.callSnackBar(
              title: "Falha ao finalizar ocorrência",
              message: error.message,
              snackStyle: SnackBarStyles.error,
            ));
    stopLoading();
  }

  void newOccurrence() async {
    if (occurrenceInput.imageUrl.isEmpty) {
      return utils.callSnackBar(
        title: "Campo obrigatório",
        message: "Imagem é obrigatório",
      );
    }

    if (occurrenceInput.description.isEmpty) {
      return utils.callSnackBar(
        title: "Campo obrigatório",
        message: "Descrição é obrigatório",
      );
    }

    if (occurrenceInput.name.isEmpty) {
      return utils.callSnackBar(
        title: "Campo obrigatório",
        message: "Título é obrigatório",
      );
    }
    setLoading(LoadingStates.createOccurrence);

    setOccurrenceLocation();
    Result<Unit, Failure> result = await createOccurrence(
      occurrenceInput,
    );
    stopLoading();
    result.when(
      (_) {
        utils.callSnackBar(
          title: "Nova ocorrência!",
          message: "Ocorrência criada com sucesso!",
          snackStyle: SnackBarStyles.success,
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
