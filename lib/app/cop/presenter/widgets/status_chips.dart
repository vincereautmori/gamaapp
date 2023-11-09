import 'package:flutter/material.dart';

import '../../../../shared/themes/palette.dart';

class StatusChips extends StatelessWidget {
  const StatusChips({super.key, required this.isInOccurence});
  final bool isInOccurence;

  @override
  Widget build(BuildContext context) {
    if (isInOccurence) {
      return Chip(
        label: const Text(
          'Em atendimento',
          style: TextStyle(
            color: Palette.white,
          ),
        ),
        deleteIcon: const Icon(Icons.taxi_alert),
        onDeleted: () {},
        deleteIconColor: Palette.white,
        color: const MaterialStatePropertyAll(Palette.warning),
      );
    }

    return Chip(
      label: const Text(
        'Disponível',
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
