import 'package:flutter/material.dart';

import '../../../../shared/themes/palette.dart';

class StatusChips extends StatelessWidget {
  const StatusChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: const Text(
        'Online',
        style: TextStyle(
          color: Palette.white,
        ),
      ),
      deleteIcon: const Icon(Icons.person),
      onDeleted: () {},
      deleteIconColor: Palette.white,
      color: const MaterialStatePropertyAll(Colors.green),
    );
  }
}
