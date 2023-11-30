import 'package:flutter/material.dart';
import 'package:gamaapp/app/citizen/presenter/pages/citizen_page.dart';
import 'package:gamaapp/app/citizen/presenter/pages/historic_page.dart';
import 'package:gamaapp/app/cop/presenter/pages/map_page.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  NavigationController();

  final _pages = <Widget>[
    const CitizenPage(),
    const MapPage(),
    const HistoricPage(),
  ].obs;
  final _pageIndex = 0.obs;

  List<Widget> get pages => _pages;
  int get pageIndex => _pageIndex.value;

  void changePage(int nextPage) => _pageIndex.value = nextPage;
}
