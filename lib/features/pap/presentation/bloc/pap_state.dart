part of 'pap_bloc.dart';

abstract class PapTransactionState {}

class PapTransactionInitial extends PapTransactionState {}

class PapTransactionLoading extends PapTransactionState {}

class PapTransactionSuccess extends PapTransactionState {
  final PapResponseModel data;
  PapTransactionSuccess({required this.data});
}

class PapTransactionError extends PapTransactionState {
  final String error;
  PapTransactionError({required this.error});
}
