
import 'package:flutter_nd/data/data_sources/cosmetic_datasource.dart';
import 'package:flutter_nd/domain/entities/cosmetic_entities.dart';

class GetCosmeticsUseCase {
  final ICosmeticDataSource dataSource;

  GetCosmeticsUseCase(this.dataSource);

  Future<List<CosmeticEntity>> call() async {
    return dataSource.getCosmetics();
  }
}