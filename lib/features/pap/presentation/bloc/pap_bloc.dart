import 'dart:developer';

import 'package:assessment_chart/core/base/api_error.dart';
import 'package:assessment_chart/core/network/network_state.dart';
import 'package:assessment_chart/di/injector.dart';
import 'package:assessment_chart/features/pap/data/model/pap_response_model.dart';
import 'package:assessment_chart/features/pap/domain/usecase/pap_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pap_event.dart';
part 'pap_state.dart';

class PapTransactionBloc
    extends Bloc<PapTransactionEvent, PapTransactionState> {
  final PapUsecase papUsecase;
  final NetworkService network = sl<NetworkService>();

  PapTransactionBloc({required this.papUsecase})
      : super(PapTransactionInitial()) {
    on<FetchPapTransactionReport>(_fetchPapTransactionReport);
  }

  _fetchPapTransactionReport(
    PapTransactionEvent event, Emitter<PapTransactionState> emit) async {
  try {
    // Log network status for debugging
    log("Checking network connection...");
    if (network.isConnected) {
      log("Network is connected");
      Either<PapResponseModel, APIError> papRes = await papUsecase.call(event);

      papRes.fold(
        (response) {
          if (response.message == "SUCCESS") {
            log("PapTransactionSuccess emitted");
            emit(PapTransactionSuccess(data: response));
          } else {
            log("PapTransactionError emitted: something went wrong");
            emit(PapTransactionError(error: "Something went wrong"));
          }
        },
        (error) {
          log("PapTransactionError emitted: ${error.message}");
          emit(PapTransactionError(error: error.message.toString()));
        },
      );
    } else {
      log("Network is not connected");
      emit(PapTransactionError(error: "No internet connection"));
    }
  } catch (e) {
    log("Exception caught: $e");
    emit(PapTransactionError(error: e.toString()));
  }
}

}


// class PapTransactionBloc
//     extends Bloc<PapTransactionEvent, PapTransactionState> {
//   final PapUsecase papUsecase;
//   final NetworkService network = sl<NetworkService>();

//   PapTransactionBloc({required this.papUsecase})
//       : super(PapTransactionInitial()) {
//     on<FetchPapTransactionReport>(_fetchPapTransactionReport);
//   }

//   _fetchPapTransactionReport(
//       PapTransactionEvent event, Emitter<PapTransactionState> emit) async {
//     try {
//       if (network.isConnected) {
//         Either<PapResponseModel, APIError> papRes =
//             await papUsecase.call(event);

//         papRes.fold((response) {
//           if (response.message == "SUCCESS") {
//             log("pApR: ${response.message.toString()}");
//             emit(PapTransactionSuccess(data: response));
//           } else {
//             emit(PapTransactionError(error: "something went wrong"));
//           }
//         }, (error) {
//           emit(PapTransactionError(error: error.message.toString()));
//         });
//       } else {
//         emit(PapTransactionError(error: "No internet c"));
//       }
//     } catch (e, stackTrace) {
//       log("Error occurred: $e");
//       log("StackTrace: $stackTrace");
//       emit(PapTransactionError(error: "e.toString()"));
//     }
//   }
// }
