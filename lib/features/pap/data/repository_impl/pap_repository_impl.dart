import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/core/network/apis.dart';
import 'package:assessment_chart/core/network/server_error.dart';
import 'package:assessment_chart/features/pap/data/model/pap_response_model.dart';
import 'package:assessment_chart/features/pap/domain/repository/pap_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class PapRepositoryImpl extends PapRepository {
  final Dio _dio;

  PapRepositoryImpl(this._dio);

  @override
  Future<Either<PapResponseModel, APIError>> fetchPapData() async {
    try {
      var papResponseModel = await _dio.post(Apis.papEndpoint, data: {});
      return Left(PapResponseModel.fromJson(papResponseModel.data));
    } on DioException catch (e) {
      return ServerError.handleError(e).then(
        (value) => Right(
          APIError(message: value, code: e.response?.statusCode ?? 0),
        ),
      );
    } on Exception catch (e) {
      return Right(
        APIError(message: e.toString(), code: 0),
      );
    }
  }
}
