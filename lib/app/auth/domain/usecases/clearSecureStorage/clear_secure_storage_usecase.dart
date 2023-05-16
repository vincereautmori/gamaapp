import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ClearSecureStorage {
  Future<Result<Unit, Failure>> clear();
}
