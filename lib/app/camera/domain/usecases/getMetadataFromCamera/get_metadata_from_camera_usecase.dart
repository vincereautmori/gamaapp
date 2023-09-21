import 'package:dio/dio.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GetMetadataFromCameraUsecase {
  Future<Result<FormData, Failure>> call();
}
