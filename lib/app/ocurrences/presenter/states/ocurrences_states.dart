import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:get/get.dart';

class OccurrenceStates {
  static RxList<OccurrencesInfo> ocurrences = RxList<OccurrencesInfo>([]);

  static Rx<OccurrencesInfo?> openedOcurrence = Rx<OccurrencesInfo?>(null);

  static Rx<OccurrencesInfo?> startedOccurrence = Rx<OccurrencesInfo?>(null);
}
