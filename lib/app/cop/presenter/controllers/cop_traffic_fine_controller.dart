import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/camera/domain/extensions/camera_extension.dart';
import 'package:gamaapp/app/cop/domain/entities/dtos/pagination_dto.dart';
import 'package:gamaapp/app/cop/domain/usecases/saveTrafficFine/save_traffic_usecase.dart';
import 'package:gamaapp/app/cop/domain/usecases/uploadFile/upload_file_usecase.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/loading.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';
import '/app/cop/presenter/states/traffic_fine_states.dart';
import '../../../camera/presenter/controllers/camera_controller.dart';
import '../../domain/entities/dtos/traffic_fine_filter_dto.dart';
import '../../domain/entities/dtos/traffic_fine_input_dto.dart';
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

  Timer? _debounce;

  bool get isUploading =>
      LoadingHandler.loadingState.value ==
      LoadingStates.uploadingTrafficFineImage;

  bool get isCreateLoading =>
      LoadingHandler.loadingState.value == LoadingStates.createTrafficFine;

  bool get isFetchLoading =>
      LoadingHandler.loadingState.value == LoadingStates.loadingTrafficFine;

  List<ListedTrafficFineInfo> get trafficFines =>
      TrafficFineStates.trafficFines;

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

  String get trafficFineImageURL => TrafficFineStates.trafficFineImageURL.value;

  late ScrollController scroll;

  @override
  void onInit() {
    super.onInit();
    cameraController = Get.find<CameraController>();
    scroll = ScrollController();
    scroll.addListener(scrollListener);

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
    clearFields();
    super.onClose();
  }

  Future<void> search() async {
    clearTrafficFines();
    await fetchAllTrafficFines();
  }

  void clearTrafficFines() {
    TrafficFineStates.pagination.value = pagination.copyWith(pageNumber: 1);
    TrafficFineStates.trafficFines.clear();
  }

  void scrollListener() {
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

  Future<void> fetchAllTrafficFines() async {
    LoadingHandler.setLoading(LoadingStates.loadingTrafficFine);

    DateTime? since = createdSince.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdSince.text)
        : null;
    DateTime? until = createdUntil.text != ""
        ? DateFormat('dd/MM/yyyy').parse(createdUntil.text)
        : null;
    String licensePlate = licensePlateFilter.text;

    Result result = await getTrafficFines(
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

  void handlePaginationResult(List<ListedTrafficFineInfo> fines) {
    if (trafficFines.isEmpty) {
      TrafficFineStates.trafficFines.value = fines;
    }

    if (trafficFines.isNotEmpty &&
        pagination.pageNumber > trafficFines.last.pageNumber) {
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
    if (licensePlate.length == 8) {
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
        }
      },
      (error) => utils.callSnackBar(
        title: "Falha ao salvar imagem",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }

  Future<void> addTrafficFine() async {
    LoadingHandler.setLoading(LoadingStates.createTrafficFine);

    String licensePlate = licensePlateCreate.text;

    Result result = await saveTrafficFine(
      TrafficFineInputDto(
        licensePlate: licensePlate.replaceAll(RegExp(r'\W+'), ''),
        latitude: 41.1425,
        longitude: -41.1425,
        trafficViolations: [
          {"id": 1}
        ],
        imageUrl: trafficFineImageURL,
      ),
    );
    LoadingHandler.stopLoading();

    result.when(
      (success) => utils.callSnackBar(
        title: "Multa salva com sucesso",
        message: "Multa salva com sucesso",
        snackStyle: SnackBarStyles.success,
      ),
      (error) => utils.callSnackBar(
        title: "Falha ao salvar multas",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
  }
}
