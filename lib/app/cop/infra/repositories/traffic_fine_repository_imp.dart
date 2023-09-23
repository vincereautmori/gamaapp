import 'package:dio/src/form_data.dart';
import 'package:gamaapp/app/cop/domain/errors/error.dart';
import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '/app/cop/domain/repositories/traffic_fine_repository.dart';
import '/app/cop/infra/datasources/traffic_fine_datasource.dart';
import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';
import '../models/traffic_fine_model.dart';

class TrafficFineRepositoryImp implements TrafficFineRepository {
  final TrafficFineDatasource datasource;

  TrafficFineRepositoryImp(this.datasource);

  @override
  Future<Result<List<ListedTrafficFineInfo>, Failure>> fetchTrafficFine({
    String? createdSince,
    String? createdUntil,
  }) async {
    try {
      List<ListedTrafficFineModel> listedTrafficFine =
          await datasource.fetchTrafficFines(
        createdSince: createdSince,
        createdUntil: createdUntil,
      );
      return Success(listedTrafficFine);
    } catch (e) {
      return Error(
        TrafficFineError(
          message: 'Algo deu errado!',
        ),
      );
    }
  }

  @override
  Future<Result<TrafficFineModel, Failure>> createTrafficFine({
    required String licensePlate,
    required double latitude,
    required double longitude,
    required List<Map<String, int>> trafficViolations,
    required String imageUrl,
  }) async {
    try {
      TrafficFineModel createdTrafficFine = await datasource.createTrafficFine(
        licensePlate: licensePlate,
        latitude: latitude,
        longitude: longitude,
        trafficViolations: trafficViolations,
        imageUrl: imageUrl,
      );

      return Success(createdTrafficFine);
    } catch (e) {
      return Error(
        TrafficFineError(
          message: 'Falha ao criar multa!',
        ),
      );
    }
  }

  @override
  Future<Result<String, Failure>> uploadFile(FormData fileFormData) async {
    try {
      String uploadedImageUrl = await datasource.uploadImage(fileFormData);
      return Success(uploadedImageUrl);
    } catch (e) {
      return Error(
        UploadImageError(
          message: 'Falha ao fazer upload da imagem',
        ),
      );
    }
  }
}
