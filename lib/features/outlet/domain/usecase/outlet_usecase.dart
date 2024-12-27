import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/core/base/base_api_usecase.dart';
import 'package:assessment_chart/features/outlet/data/model/outlet_response_model.dart';
import 'package:assessment_chart/features/outlet/domain/repository/outlet_repository.dart';
import 'package:dartz/dartz.dart';

class OutletUsecase  with BaseApiUseCase{
  final OutletRepository outletRepository;

  OutletUsecase({
    required this.outletRepository,
  });


  @override
  Future<Either<OutletResponseModel, APIError>> call(params) {
    return outletRepository.fetchOutletData();
  }
}