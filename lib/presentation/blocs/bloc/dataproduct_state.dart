import 'package:flutter_nd/data/models/dataproduct_model.dart';

abstract class DataProductState {}

class DataProductInitial extends DataProductState {}

class DataProductLoading extends DataProductState {}

class DataProductLoaded extends DataProductState {
  final List<Cosmetic> products;

  DataProductLoaded({required this.products});
}

class DataProductError extends DataProductState {
  final String message;

  DataProductError({required this.message});
}