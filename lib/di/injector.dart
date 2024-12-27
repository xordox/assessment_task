
import 'package:assessment_chart/core/network/dio_client.dart';
import 'package:assessment_chart/core/network/network_state.dart';
import 'package:assessment_chart/features/outlet/data/repository_impl/outlet_repository_impl.dart';
import 'package:assessment_chart/features/outlet/domain/repository/outlet_repository.dart';
import 'package:assessment_chart/features/outlet/domain/usecase/outlet_usecase.dart';
import 'package:assessment_chart/features/pap/data/repository_impl/pap_repository_impl.dart';
import 'package:assessment_chart/features/pap/domain/repository/pap_repository.dart';
import 'package:get_it/get_it.dart';

import '../features/outlet/presentation/bloc/outlet_bloc.dart';
import '../features/pap/domain/usecase/pap_usecase.dart';
import '../features/pap/presentation/bloc/pap_bloc.dart';

GetIt sl = GetIt.instance;

Future setup() async {


    sl.registerSingleton<NetworkService>(NetworkService());
  sl<NetworkService>().listenNetwork();

   sl.registerLazySingleton(() => DioClient.getInstance());


  // Registering the repositories 
  sl.registerLazySingleton<OutletRepository>(() => OutletRepositoryImpl(sl()));
  sl.registerLazySingleton<PapRepository>(() => PapRepositoryImpl(sl()));

  // Registering the use cases
  sl.registerLazySingleton(() => OutletUsecase(outletRepository: sl()));
  sl.registerLazySingleton(() => PapUsecase(papRepository: sl()));

  // Registering the BLoCs
  sl.registerFactory(() => OutletBloc(outletUsecase: sl()));
  sl.registerFactory(() => PapTransactionBloc(papUsecase: sl()));
}