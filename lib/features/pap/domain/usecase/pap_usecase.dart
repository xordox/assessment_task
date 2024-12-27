import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/core/base/base_api_usecase.dart';
import 'package:assessment_chart/features/pap/data/model/pap_response_model.dart';
import 'package:assessment_chart/features/pap/domain/repository/pap_repository.dart';
import 'package:dartz/dartz.dart';

class PapUsecase  with BaseApiUseCase{
  final PapRepository papRepository;

  PapUsecase({
    required this.papRepository,
  });


  @override
  Future<Either<PapResponseModel, APIError>> call(params) {
    return papRepository.fetchPapData();
  }
}