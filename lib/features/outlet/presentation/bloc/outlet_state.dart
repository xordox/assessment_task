part of 'outlet_bloc.dart';

abstract class OutletState {}

class OutletInitial extends OutletState {}

class OutletLoading extends OutletState {}

class OutletSuccess extends OutletState {
  final OutletResponseModel outletResponseModel;
  OutletSuccess({required this.outletResponseModel});
}

class OutletError extends OutletState {
  final String error;
  OutletError({required this.error});
}
