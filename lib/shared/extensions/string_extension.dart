import 'package:brasil_fields/brasil_fields.dart';

extension AuthStringsExtension on String {
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
      .hasMatch(this);

  bool get isDocumentValid => UtilBrasilFields.isCPFValido(this);
}
