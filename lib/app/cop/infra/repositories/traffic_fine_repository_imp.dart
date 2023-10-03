import 'package:dio/dio.dart';
import 'package:gamaapp/app/cop/domain/errors/error.dart';
import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '/app/cop/domain/repositories/traffic_fine_repository.dart';
import '/app/cop/infra/datasources/traffic_fine_datasource.dart';
import '../../domain/entities/trafficFine/listed_traffic_fine_info.dart';

class TrafficFineRepositoryImp implements TrafficFineRepository {
  final TrafficFineDatasource datasource;

  TrafficFineRepositoryImp(this.datasource);

  @override
  Future<Result<List<ListedTrafficFineInfo>, Failure>> fetchTrafficFine({
    String? licensePlate,
    String? createdSince,
    String? createdUntil,
  }) async {
    try {
      List<ListedTrafficFineModel> listedTrafficFine =
          await datasource.fetchTrafficFines(
        licensePlate: licensePlate,
        createdSince: createdSince,
        createdUntil: createdUntil,
      );
      return Success(listedTrafficFine);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Error(
          TrafficFineError(
            message:
                e.response?.data['search.LicensePlate'][0] ?? "Algo deu errado",
          ),
        );
      }

      return Error(
        TrafficFineError(
          message: "Falha na requisição",
        ),
      );
    } catch (e) {
      return Error(
        TrafficFineError(
          message: "Algo deu errado",
        ),
      );
    }
  }

  @override
  Future<Result<int, Failure>> createTrafficFine({
    required String licensePlate,
    required double latitude,
    required double longitude,
    required List<Map<String, int>> trafficViolations,
    required String imageUrl,
  }) async {
    try {
      int createdStatusCode = await datasource.createTrafficFine(
        licensePlate: licensePlate,
        latitude: latitude,
        longitude: longitude,
        trafficViolations: trafficViolations,
        imageUrl: imageUrl,
      );

      if (createdStatusCode != 201) {
        return Error(TrafficFineError(message: "Falha ao criar multa"));
      }

      return Success(createdStatusCode);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return Error(
          TrafficFineError(
            message: e.response?.data['createTrafficFineCommand.LicensePlate']
                    [0] ??
                "Algo deu errado",
          ),
        );
      }

      return Error(
        TrafficFineError(
          message: "Falha na requisição",
        ),
      );
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
