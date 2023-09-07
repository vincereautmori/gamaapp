import 'package:flutter/material.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:gamaapp/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class NewOcurrencePage<T> extends GetView<T> {
  const NewOcurrencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova ocorrência')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const GamaTextField(
                label: 'Selecione qual o tipo da ocorrência',
                placeholder: 'Busque um tipo de ocorrência',
              ),
              const SizedBox(height: 16),
              const GamaTextField(
                label: 'Faça uma breve descrição do problema',
                placeholder:
                    'Nos de detalhes da ocorrência. Ex: Ocorreu um acidente entre 2 carros',
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              const Text('Fotos'),
              const SizedBox(height: 16),
              const Text('Arquivo 1'),
              const SizedBox(height: 16),
              const ListTile(
                leading: Icon(
                  Icons.pin_drop_outlined,
                ),
                tileColor: Palette.greyBackground,
                title: Text('Rua dos bobos, 0'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bairro, Cidade - UF'),
                    Text('21.111111, 32.111111'),
                  ],
                ),
                trailing: Icon(
                  Icons.refresh,
                ),
              ),
              const SizedBox(height: 32),
              GamaButton(text: 'Salvar', onPressed: () {}, isLoading: false)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {},
        icon: const Icon(
          Icons.photo_camera_outlined,
        ),
        label: const Text('Camera'),
      ),
    );
  }
}
