import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:gamaapp/shared/config/config.dart';
import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/loading.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../../locations/presenter/controllers/location_controller.dart';
import '../../../ocurrences/infra/models/occurrences/ocurrences_model.dart';
import '../../../ocurrences/presenter/controllers/ocurrences_controller.dart';

class CopHomeController extends GetxController with Loading {
  final String serverUrl = Config.socketUrl;
  late HubConnection hubConnection;
  final OcurrencesController _ocurrenceController =
      Get.find<OcurrencesController>();
  final LocationController _locationController = Get.find<LocationController>();

  bool get goingToOccurrences =>
      loadingState.value == LoadingStates.occurrencesMap;

  @override
  void onInit() {
    super.onInit();
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

    startSignalRConnection();
  }

  Future<void> startSignalRConnection() async {
    hubConnection.on("ReceiveMessage", (messages) {
      if (messages != null) {
        if (messages.first is List) {
          _ocurrenceController.fillOccurrences(
            OcurrencesModel.fromJsonList(messages.first),
          );
        } else {
          _ocurrenceController.notifyNewOccurrence(
            OcurrencesModel.fromJson(messages.first),
          );
        }
      }
    });

    hubConnection.onclose((error) {
      utils.callSnackBar(
        title: "Conexão perdida",
        message: "$error",
        snackStyle: SnackBarStyles.error,
      );
    });

    hubConnection.start().then((_) {
      utils.callSnackBar(
        title: "Ocorrências",
        message: "Conectado ao servidor de ocorrências com sucesso",
        snackStyle: SnackBarStyles.success,
      );

      subscribeWithinRadius(-22.736491, -47.332322, 20000);
    }).catchError((error) {
      utils.callSnackBar(
        title: "Error starting SignalR connection",
        message: "$error",
        snackStyle: SnackBarStyles.error,
      );
    });
  }

  void subscribeWithinRadius(double latitude, double longitude, double radius) {
    hubConnection
        .invoke("Subscribe", args: <double>[latitude, longitude, radius]);
  }

  void unsubscribe() {
    hubConnection.invoke("Unsubscribe");
  }

  @override
  void onClose() {
    hubConnection.stop();
    super.onClose();
  }

  Future<void> goToOcurrence() async {
    setLoading(LoadingStates.occurrencesMap);
    await _locationController.determinePlace();
    Get.toNamed('/cop/${RoutesNames.occurrence}');
    stopLoading();
  }

  void goToTrafficFine() => Get.toNamed('/cop${RoutesNames.trafficFine}');
}
