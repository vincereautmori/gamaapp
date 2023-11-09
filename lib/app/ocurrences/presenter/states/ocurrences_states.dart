import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:get/get.dart';

class OcurrenceStates {
  static RxList<OcurrencesInfo> ocurrences = RxList<OcurrencesInfo>([]);

  static Rx<OcurrencesInfo?> openedOcurrence = Rx<OcurrencesInfo?>(null);

  static final RxBool isInOccurrence = RxBool(false);
}
