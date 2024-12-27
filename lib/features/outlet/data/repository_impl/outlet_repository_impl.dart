import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/core/network/apis.dart';
import 'package:assessment_chart/core/network/server_error.dart';
import 'package:assessment_chart/features/outlet/data/model/outlet_response_model.dart';
import 'package:assessment_chart/features/outlet/domain/repository/outlet_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class OutletRepositoryImpl extends OutletRepository{
  final Dio _dio;

  OutletRepositoryImpl( this._dio);

  @override
  Future<Either<OutletResponseModel, APIError>> fetchOutletData() async{
    try{
       var outletResponseModel = await _dio.post(Apis.outletEndpoint, data: {});
        return Left(OutletResponseModel.fromJson(outletResponseModel.data));
    } on DioException catch(e) {
      return ServerError.handleError(e).then(
        (value) => Right(APIError(message: value, code: e.response?.statusCode??0),),
      );
    } on Exception catch(e) {
      return Right(APIError(message: e.toString(), code: 0),);
    }
  }

 }