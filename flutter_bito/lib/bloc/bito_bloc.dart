import 'package:flutter_bito/models/bito_data.dart';
import '../api_manager/api_provider.dart';
import '../target_type/bito_info_target.dart';
import 'bito_event.dart';
import 'bito_state.dart';
import 'package:bloc/bloc.dart';

class BitoBloc extends Bloc<BitoEvent, BitoState> {
   final ApiProvider apiProvider;

  BitoBloc(this.apiProvider) : super(BitoInitial()) {
    on<FetchBitoData>(_onFetchBitoData);
  }

 Future<void> _onFetchBitoData(FetchBitoData event, Emitter<BitoState> emit) async {
  emit(BitoLoading());
  try {
    final response = await apiProvider.request<List<BitoData>>(
      BitoInfoInfoTarget(),
      (json) => (json as List).map((item) => BitoData.fromJson(item)).toList(),
    );
    
    final uniqueBitoData = <BitoData>{};
    final nameSet = <String>{};

    for (var bitoData in response.data) {
      if (nameSet.add(bitoData.currency)) {
        uniqueBitoData.add(bitoData);
      }
    }

    emit(BitoLoaded(uniqueBitoData.toList()));
  } catch (error) {
    emit(BitoError(error.toString()));
  }
}
}
