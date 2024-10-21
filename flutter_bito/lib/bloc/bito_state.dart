import '../models/bito_data.dart';

abstract class BitoState {}

class BitoInitial extends BitoState {}

class BitoLoading extends BitoState {}

class BitoLoaded extends BitoState {
  final List<BitoData> data;
  BitoLoaded(this.data);
}

class BitoError extends BitoState {
  final String message;
  BitoError(this.message);
}
