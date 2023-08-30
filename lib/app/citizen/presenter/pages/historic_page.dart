import 'package:flutter/material.dart';
import 'package:gamaapp/app/citizen/presenter/controllers/historic_controller.dart';
import 'package:get/get.dart';

class HistoricPage extends GetView<HistoricController> {
  const HistoricPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('HistoricController'),
      ),
    );
  }
}
