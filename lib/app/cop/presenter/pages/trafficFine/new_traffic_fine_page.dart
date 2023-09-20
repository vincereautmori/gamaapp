import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/shared/extensions/datetime_extension.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:gamaapp/shared/widgets/textfield.dart';
import 'package:get/get.dart';

import '../../../../../shared/widgets/square_line.dart';

class NewTrafficFinePage extends GetView<CopTrafficFineController> {
  const NewTrafficFinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar multa'),
        foregroundColor: Palette.white,
        backgroundColor: Palette.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Palette.primary,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Palette.white,
                    ),
                    textColor: Palette.white,
                    title: const Text(
                      'Hora da ocorrência',
                    ),
                    subtitle: Text(
                      DateTime.now().formatDate('dd/MM/yy - hh:mm:ss')!,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ListTile(
                    leading: const Icon(
                      Icons.map_outlined,
                      color: Palette.white,
                    ),
                    textColor: Palette.white,
                    title: const Text(
                      'Local da ocorrência',
                    ),
                    subtitle: Text(
                      DateTime.now().formatDate('dd/MM/yy - hh:mm:ss')!,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const ListTile(
                    leading: Icon(
                      Icons.person_pin_outlined,
                      color: Palette.white,
                    ),
                    textColor: Palette.white,
                    title: Text(
                      'Oficial responsável',
                    ),
                    subtitle: Text(
                      "Policial Dev",
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SquaresLines(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GamaTextField(
                label: 'Placa',
                placeholder: "Informe o número da placa",
                masks: [PlacaVeiculoInputFormatter()],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Palette.greyBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.photo_outlined,
                    ),
                  ),
                  title: Text('Nenhuma imagem'),
                  trailing: Icon(Icons.add),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Palette.lightGrey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Infrações',
                    style: Texts.cardTitle,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar infração'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.save_outlined),
        label: const Text('Gravar multa'),
      ),
    );
  }
}
