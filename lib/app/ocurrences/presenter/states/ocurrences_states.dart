import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:get/get.dart';

import '../../../../shared/dtos/pagination_dto.dart';
import '../../domain/entities/dtos/occurrence_input.dart';
import '../../domain/entities/ocurrences/listed_occurrences_info.dart';
import '../../domain/entities/ocurrences/occurrences_map_info.dart';
import '../../domain/entities/ocurrences/ocurrences_info.dart';
import '../../domain/entities/properties/properties_info.dart';

class OccurrenceStates {
  static RxList<OccurrencesMapInfo> mapOcurrences =
      RxList<OccurrencesMapInfo>([]);

  static RxList<ListedOccurrencesInfo> occurrences =
      RxList<ListedOccurrencesInfo>([]);

  static Rx<OccurrencesInfo?> openedOcurrence = Rx<OccurrencesInfo?>(null);

  static Rx<OccurrencesInfo?> startedOccurrence = Rx<OccurrencesInfo?>(null);

  static final Rx<PaginationDto> pagination = Rx(const PaginationDto());

  static final Rx<ScrollDirection?> scrollDirection =
      Rx<ScrollDirection?>(null);

  static final Rx<TextEditingController> createdSince =
      Rx(TextEditingController());

  static final Rx<TextEditingController> createdUntil = Rx(
    TextEditingController(
      text: DateTime.now().formatDate('dd/MM/yyyy'),
    ),
  );

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
