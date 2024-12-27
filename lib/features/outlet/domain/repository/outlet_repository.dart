import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/features/outlet/data/model/outlet_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class OutletRepository {
  Future<Either<OutletResponseModel, APIError>> fetchOutletData();
}
