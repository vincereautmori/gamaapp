import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/cop/domain/entities/trafficFine/listed_traffic_fina_info.dart';

class TrafficFineStates {
  static final RxList<ListedTrafficFineInfo> trafficFines =
      <ListedTrafficFineInfo>[].obs;
  static final Rx<TextEditingController> createdSince =
      Rx(TextEditingController());
  static final Rx<TextEditingController> createdUntil =
      Rx(TextEditingController());
}
