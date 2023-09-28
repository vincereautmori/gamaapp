import 'package:flutter/material.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:get/get.dart';

import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';

class TrafficFineStates {
  static final RxList<ListedTrafficFineInfo> trafficFines =
      <ListedTrafficFineInfo>[].obs;

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
}
