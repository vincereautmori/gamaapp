import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:gamaapp/shared/themes/images.dart';
import 'package:gamaapp/shared/widgets/buttons/button.dart';
import 'package:gamaapp/shared/widgets/square_line.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/auth/external/providers/auth_provider.dart';
import '../themes/palette.dart';

class WarningPage extends StatelessWidget {
  const WarningPage({super.key});
  @override
  Widget build(BuildContext context) {
    AuthorizationProvider authorizationProvider =
        AuthorizationProvider(const FlutterSecureStorage());
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Palette.primary,
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Image.asset(
                  Images.sirene,
                  width: 264,
                ),
              ),
            ),
            const SquaresLines(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Prezados usuários,",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  color: Palette.warning,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Gostaríamos de informar que o aplicativo atual encontra-se em fase de desenvolvimento. Neste estágio, não dispõe de todas as funcionalidades da versão final e pode conter alguns bugs. Estamos trabalhando para aprimorar sua experiência e agradecemos pela compreensão.',
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: GamaButton(
                text: "Entendi",
                onPressed: () {
                  authorizationProvider.setToHideWarningPageAtFirst();
                  Get.offAndToNamed(RoutesNames.splash);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
