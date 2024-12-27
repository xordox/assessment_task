import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/core/network/network_state.dart';
import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/outlet/data/model/outlet_response_model.dart';
import 'package:assessment_chart/features/outlet/domain/usecase/outlet_usecase.dart';
import 'package:assessment_chart/main.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'outlet_event.dart';
part 'outlet_state.dart';

class OutletBloc extends Bloc<OutletEvent, OutletState> {
 final OutletUsecase outletUsecase;
 final NetworkService network = sl<NetworkService>();

 OutletBloc({
  required this.outletUsecase
 }): super(OutletInitial()){
  on<FetchOutlet>(_fetchOutletData);
 }

 _fetchOutletData(OutletEvent event, Emitter<OutletState> emit) async {
    try{
      if(network.isConnected){
        emit(OutletInitial());
        Either<OutletResponseModel, APIError> outletRes = await outletUsecase.call(event);

        outletRes.fold((response){
          if(response.message == "SUCCESS"){
            emit(OutletSuccess(outletResponseModel: response
             
            ));
          } else{
            emit(OutletError(error: "something went wrong"));
          } 

        }, 
        (error){
            emit(OutletError(error: error.message.toString()));
        });

      } else{
        emit(OutletError(error: "No internet connection"));
      }
    } catch (e) {
      emit(OutletError(error: e.toString()));

    }

  }


}
