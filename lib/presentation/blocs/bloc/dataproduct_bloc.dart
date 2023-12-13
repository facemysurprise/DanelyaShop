import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nd/data/repository/dataproduct_repository.dart';
import 'package:flutter_nd/presentation/blocs/bloc/dataproduct_event.dart';
import 'package:flutter_nd/presentation/blocs/bloc/dataproduct_state.dart';

class DataProductBloc extends Bloc<DataProductEvent, DataProductState> {
  final CosmeticApiService apiService;

  DataProductBloc({required this.apiService}) : super(DataProductInitial()) {
    on<FetchDataProduct>(_onFetchDataProduct);
  }

  Future<void> _onFetchDataProduct(FetchDataProduct event, Emitter<DataProductState> emit) async {
    emit(DataProductLoading());
    try {
      final products = await apiService.getCosmetics();
      emit(DataProductLoaded(products: products));
    } catch (error) {
      emit(DataProductError(message: error.toString()));
    }
  }
}