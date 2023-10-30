import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:get/get.dart';

class FineImage extends StatefulWidget {
  const FineImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<FineImage> createState() => _FineImageState();
}

class _FineImageState extends State<FineImage> {
  CopTrafficFineController controller = Get.find();
  List<int>? fileStream;

  @override
  void initState() {
    Future(
      () async {
        fileStream = await controller.loadImage(widget.imageUrl);
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fileStream == null) {
      return const Text("Teste");
    }
    return Image.memory(
      Uint8List.fromList(fileStream!),
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool? wasSynchronouslyLoaded) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        );
      },
    );
  }
}
