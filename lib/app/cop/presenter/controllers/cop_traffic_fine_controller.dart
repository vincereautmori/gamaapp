import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/cop/domain/entities/dtos/pagination_dto.dart';
import 'package:gamaapp/app/cop/domain/usecases/loadFile/load_file_usecase.dart';
import 'package:gamaapp/app/cop/domain/usecases/saveTrafficFine/save_traffic_usecase.dart';
import 'package:gamaapp/app/cop/domain/usecases/uploadFile/upload_file_usecase.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/loading.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../camera/presenter/controllers/camera_controller.dart';
import '../../../locations/presenter/states/location_states.dart';
import '../../domain/entities/dtos/traffic_fine_filter_dto.dart';
import '../../domain/entities/dtos/traffic_fine_input_dto.dart';
import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';
import '../../domain/entities/trafficFine/traffic_fine_info.dart';
import '../../domain/usecases/getAllTrafficFines/get_all_traffic_fine_usecase.dart';
import '../../domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';
import '../states/traffic_violation_states.dart';
import '/app/cop/presenter/states/traffic_fine_states.dart';

class CopTrafficFineController extends GetxController {
  final GetAllTrafficFineUsecase getAllTrafficFines;
  final GetTrafficFineUsecase getTrafficFine;
  final SaveTrafficUsecase saveTrafficFine;
  final UploadFileUsecase uploadFile;
  final LoadFileUsecase loadFile;

  late CameraController cameraController;

  CopTrafficFineController({
    required this.getAllTrafficFines,
    required this.getTrafficFine,
    required this.saveTrafficFine,
    required this.uploadFile,
    required this.loadFile,
  });

  Timer? _debounce;

  bool get isUploading =>
      LoadingHandler.loadingState.value ==
      LoadingStates.uploadingTrafficFineImage;

  bool get isCreateLoading =>
      LoadingHandler.loadingState.value == LoadingStates.createTrafficFine;

  bool get isFetchAllLoading =>
      LoadingHandler.loadingState.value == LoadingStates.loadingAllTrafficFines;

  bool get isFetchLoaging =>
      LoadingHandler.loadingState.value == LoadingStates.loadingTrafficFine;

  List<ListedTrafficFineInfo> get allTrafficFines =>
      TrafficFineStates.trafficFines;

  TrafficFineInfo? get trafficFine => TrafficFineStates.openedTrafficFine.value;

  TextEditingController get createdSince =>
      TrafficFineStates.createdSince.value;

  TextEditingController get createdUntil =>
      TrafficFineStates.createdUntil.value;

  TextEditingController get licensePlateFilter =>
      TrafficFineStates.licensePlateFilter.value;

  TextEditingController get licensePlateCreate =>
      TrafficFineStates.licensePlateCreate.value;

  PaginationDto get pagination => TrafficFineStates.pagination.value;

  int get imageBytesCount => TrafficFineStates.trafficFineImageBytesCount.value;
  int get imageBytesTotal => TrafficFineStates.trafficFineImageBytesTotal.value;

  bool get hideAddButton =>
      TrafficFineStates.scrollDirection.value == ScrollDirection.reverse;

  String get trafficFineImageURL => TrafficFineStates.trafficFineImageURL.value;

  Position? get position => LocationStates.position.value;

  List<int> get loadedImage => TrafficFineStates.loadedImage;

  late ScrollController scroll;

  @override
  void onInit() {
    super.onInit();
    cameraController = Get.find<CameraController>();
    scroll = ScrollController();
    if (!scroll.hasClients) {
      scroll.addListener(scrollListener);
    }

    createdSince.addListener(() async {
      await search();
    });
    createdUntil.addListener(() async {
      await search();
    });
    fetchAllTrafficFines();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    scroll.dispose();
    clearFields();
    clearInputs();
    super.onClose();
  }

  Future<void> search() async {
    clearTrafficFines();
    await fetchAllTrafficFines();
  }

  void clearOpenedTrafficFine() {
    TrafficFineStates.openedTrafficFine.value = null;
    loadedImage.clear();
  }

  void clearTrafficFines() {
    TrafficFineStates.pagination.value =
        pagination.copyWith(pageNumber: 1, count: 0);
    TrafficFineStates.trafficFines.clear();
  }

  void scrollListener() {
    print(scroll.position.userScrollDirection);

    if (scroll.offset >= scroll.position.maxScrollExtent &&
        !scroll.position.outOfRange) {
      nextPage();
    }
    // if (scroll.offset <= scroll.position.minScrollExtent &&
    //     !scroll.position.outOfRange &&
    //     pagination.pageNumber > 1) {
    //   previousPage();
    //   //TODO ir retornando até acabar as páginas. Se necessário, fazer um novo fetch e adicionar ao inicio da lista. Ex> Avancei 4 páginas, a página 1 foi removida da lista, ao voltar 3, ele da o fetch novamente na página 1
    // }
  }

  void clearFields() {
    TrafficFineStates.trafficFines.clear();
    TrafficFineStates.createdSince.value.text = "";
    TrafficFineStates.createdUntil.value.text = "";
    TrafficFineStates.licensePlateFilter.value.text = "";
    TrafficFineStates.licensePlateCreate.value.text = "";
  }

  void clearInputs() {
    licensePlateCreate.text = '';
    TrafficViolationStates.selectedTrafficViolations.clear();
    TrafficFineStates.trafficFineImageURL.value = "";
    TrafficFineStates.trafficFineImageBytesCount.value = 0;
  }

  Future<void> fetchAllTrafficFines() async {
    if (pagination.count == allTrafficFines.length &&
        allTrafficFines.isNotEmpty) {
      return utils.callSnackBar(
        title: 'Nenhuma multa nova',
        message: "Parece que você carregou todas as multas",
        snackStyle: SnackBarStyles.warning,
      );
    }

    LoadingHandler.setLoading(LoadingStates.loadingAllTrafficFines);

    DateTime? since = createdSince.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdSince.text)
        : null;
    DateTime? until = createdUntil.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdUntil.text)
        : null;
    String licensePlate = licensePlateFilter.text;

    Result result = await getAllTrafficFines(
      TrafficFineFilterDto(
          createdSince: since,
          createdUntil: until,
          licensePlate: licensePlate,
          pagination: pagination),
    );
    LoadingHandler.stopLoading();
    result.when(
      (trafficFines) => handlePaginationResult(trafficFines),
      (error) => utils.callSnackBar(
        title: "Falha ao carregar multas",
        message: error.message,
        snackStyle: SnackBarStyles.warning,
      ),
    );
  }

  Future<void> getTrafficFineById(int id) async {
    LoadingHandler.setLoading(LoadingStates.loadingTrafficFine);

    Result<TrafficFineInfo, Failure> result = await getTrafficFine(id);
    LoadingHandler.stopLoading();
    result.when(
      (trafficFine) {
        TrafficFineStates.openedTrafficFine.value = trafficFine;
      },
      (error) => utils.callSnackBar(
        title: "Falha ao carregar multa",
        message: error.message,
      ),
    );
  }

  void handlePaginationResult(List<ListedTrafficFineInfo> fines) {
    if (allTrafficFines.isEmpty) {
      TrafficFineStates.trafficFines.value = fines;
    }

    if (allTrafficFines.isNotEmpty &&
        pagination.pageNumber > allTrafficFines.last.pageNumber) {
      TrafficFineStates.trafficFines.addAll(fines);
    }
  }

  void nextPage() async {
    TrafficFineStates.pagination.value =
        pagination.copyWith(pageNumber: pagination.pageNumber + 1);

    await fetchAllTrafficFines();
  }

  Future<void> debounceSearchByLicensePlate(String licensePlate) async {
    // if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    // _debounce = Timer(const Duration(milliseconds: 500), () async {
    //   await fetchAllTrafficFines();
    // });
    int maxLength = 7;

    if (licensePlate.contains('-')) {
      maxLength = 8;
    }
    if (licensePlate.length == maxLength || licensePlate.isEmpty) {
      await search();
    }
  }

  Future<void> uploadImage() async {
    LoadingHandler.setLoading(LoadingStates.uploadingTrafficFineImage);
    Result<XFile?, Failure> result = await cameraController.getFileFromCamera();
    result.when(
      (file) async {
        if (file != null) {
          Dio.FormData? formData = await file.toFormData('fileName');
          Result uploadResult = await uploadFile(formData!);
          LoadingHandler.stopLoading();
          String url = uploadResult.tryGetSuccess();

          TrafficFineStates.trafficFineImageURL.value = url;
          TrafficFineStates.loadedImage.clear();
          TrafficFineStates.loadedImage.addAll(await file.readAsBytes());
        } else {
          TrafficFineStates.trafficFineImageBytesCount.value = 0;
        }
      },
      (error) => utils.callSnackBar(
        title: "Falha ao salvar imagem",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }

  Future<void> loadImage(String url) async {
    Result<List<int>, Failure> result = await loadFile(url);
    return result.when((fileBytes) {
      TrafficFineStates.loadedImage.addAll(fileBytes);
    }, (error) {
      utils.callSnackBar(
          title: "Falha ao carregar imagem", message: error.message);
    });
  }

  Future<void> addTrafficFine() async {
    LoadingHandler.setLoading(LoadingStates.createTrafficFine);

    String licensePlate = licensePlateCreate.text;
    List<Map<String, int>> violationIds = TrafficViolationStates
        .selectedTrafficViolations
        .map((violation) => {"id": violation.id})
        .toList();

    Result result = await saveTrafficFine(
      TrafficFineInputDto(
        licensePlate: licensePlate,
        latitude: position?.latitude ?? 0,
        longitude: position?.longitude ?? 0,
        trafficViolations: violationIds,
        imageUrl: trafficFineImageURL,
      ),
    );
    LoadingHandler.stopLoading();

    result.when(
      (success) {
        Get.back();
        utils.callSnackBar(
          title: "Multa salva com sucesso",
          message: "Multa salva com sucesso",
          snackStyle: SnackBarStyles.success,
        );
        clearInputs();
      },
      (error) => utils.callSnackBar(
        title: "Falha ao salvar multas",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }
}
