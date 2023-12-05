import 'package:flutter/material.dart';
import 'package:gamaapp/app/citizen/presenter/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<NavigationController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Text(
          'Bem vindo, André',
          style: TextStyle(color: context.theme.splashColor, fontSize: 24),
        ),
        elevation: 0,
        actions: const [
          CircleAvatar(),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Obx(() {
        Widget currentPage = controller.pages[controller.pageIndex];
        return currentPage;
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.pageIndex,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.map,
                ),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time,
                ),
                label: 'Recente',
              ),
            ],
          )),
    );
  }
}
