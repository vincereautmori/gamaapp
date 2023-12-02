import 'package:get/get.dart';

enum LoadingStates {
  createTrafficFine,
  createOccurrence,
  loadingAllTrafficFines,
  loadingTrafficFine,
  loadingTrafficViolations,
  uploadingTrafficFineImage,
  uploadingOccurrenceImage,
  occurrencesMap,
  occurrenceProperties,
  creteUser,
  login,
}

mixin Loading {
  Rx<LoadingStates?> loadingState = Rx(null);

  void setLoading(LoadingStates state) => loadingState.value = state;

  void stopLoading() => loadingState.value = null;
}
