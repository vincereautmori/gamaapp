import 'package:flutter/material.dart';

import '../../../../shared/themes/palette.dart';

class StatusChips extends StatelessWidget {
  const StatusChips({
    super.key,
    required this.isInOccurence,
    this.openOccurrenceAction,
  });
  final bool isInOccurence;
  final VoidCallback? openOccurrenceAction;

  @override
  Widget build(BuildContext context) {
    if (isInOccurence) {
      return ActionChip(
        label: const Text(
          'Em atendimento',
          style: TextStyle(
            color: Palette.white,
          ),
        ),
        avatar: const Icon(
          Icons.taxi_alert,
          color: Colors.white,
        ),
        onPressed: openOccurrenceAction,
        surfaceTintColor: Colors.white,
        color: const MaterialStatePropertyAll(Palette.warning),
      );
    }

    return const Chip(
      label: Text(
        'Disponível',
        style: TextStyle(
          color: Palette.white,
        ),
      ),
      avatar: Icon(Icons.person, color: Palette.white),
      color: MaterialStatePropertyAll(Colors.green),
    );
  }
}
