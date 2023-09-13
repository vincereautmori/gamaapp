import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  DateTime? get date => this;
  String? formatDate(String mask) =>
      date != null ? DateFormat(mask).format(date!) : null;
}
