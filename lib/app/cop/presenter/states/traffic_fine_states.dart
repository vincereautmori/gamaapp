import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamaapp/shared/dtos/pagination_dto.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:get/get.dart';

import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';
import '../../domain/entities/trafficFine/traffic_fine_info.dart';

class TrafficFineStates {
  static final RxList<ListedTrafficFineInfo> trafficFines =
      <ListedTrafficFineInfo>[].obs;

  static final Rx<ScrollDirection?> scrollDirection =
      Rx<ScrollDirection?>(null);

  static final Rx<TrafficFineInfo?> openedTrafficFine =
      Rx<TrafficFineInfo?>(null);

  static final Rx<TextEditingController> createdSince =
      Rx(TextEditingController());

  static final Rx<TextEditingController> createdUntil = Rx(
    TextEditingController(
      text: DateTime.now().formatDate('dd/MM/yyyy'),
    ),
  );

  static final Rx<TextEditingController> licensePlateFilter = Rx(
    TextEditingController(text: ""),
  );

  static final Rx<TextEditingController> licensePlateCreate = Rx(
    TextEditingController(text: ""),
  );

  static final RxString trafficFineImageURL = "".obs;

  static final RxInt trafficFineImageBytesCount = 0.obs;
  static final RxInt trafficFineImageBytesTotal = 1.obs;

  static final Rx<PaginationDto> pagination = Rx(const PaginationDto());

  static final RxList<int> loadedImage = RxList();
}
