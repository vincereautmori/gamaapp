import 'package:get/get.dart';

class LoadingHandler {
  static Rx<LoadingStates?> loadingState = Rx(null);

  static void setLoading(LoadingStates state) => loadingState.value = state;

  static void stopLoading() => loadingState.value = null;
}

enum LoadingStates {
  createTrafficFine,
  loadingAllTrafficFines,
  loadingTrafficFine,
  loadingTrafficViolations,
  uploadingTrafficFineImage,
  occurrencesMap,
  createOccurrence,
}

mixin Loading {
  Rx<LoadingStates?> loadingState = Rx(null);

  void setLoading(LoadingStates state) => loadingState.value = state;

  void stopLoading() => loadingState.value = null;
}
