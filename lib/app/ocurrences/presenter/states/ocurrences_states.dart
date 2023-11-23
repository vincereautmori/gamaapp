import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:get/get.dart';

import '../../domain/entities/dtos/ocurrency_input.dart';
import '../../domain/entities/properties/properties_info.dart';

class OccurrenceStates {
  static RxList<OccurrencesInfo> ocurrences = RxList<OccurrencesInfo>([]);

  static Rx<OccurrencesInfo?> openedOcurrence = Rx<OccurrencesInfo?>(null);

  static Rx<OccurrencesInfo?> startedOccurrence = Rx<OccurrencesInfo?>(null);

  static Rx<OccurrenceInput> occurrenceInput = Rx<OccurrenceInput>(
    OccurrenceInput(
      latitude: -22.7704398,
      longitude: -47.3310491,
      location: "",
      name: "",
      description: "",
      occurrenceStatusId: 1,
      occurrenceUrgencyLevelId: 1,
      occurrenceTypeId: 1,
      imageUrl: "",
    ),
  );

  static Rx<List<PropertiesInfo>> occurrenceTypes =
      Rx<List<PropertiesInfo>>([]);

  static final RxList<int> loadedImage = RxList();

  static final RxInt trafficFineImageBytesCount = 0.obs;
  static final RxInt trafficFineImageBytesTotal = 1.obs;
}
