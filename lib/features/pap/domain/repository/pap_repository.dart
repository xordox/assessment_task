import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/features/pap/data/model/pap_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class PapRepository {
  Future<Either<PapResponseModel, APIError>> fetchPapData();
}