import 'package:flutter_nd/data/repository/dataproduct_repository.dart';
import 'package:flutter_nd/domain/entities/cosmetic_entities.dart';
abstract class ICosmeticDataSource {
  Future<List<CosmeticEntity>> getCosmetics();
}
class CosmeticDataSource implements ICosmeticDataSource {
  final CosmeticApiService apiService;

  CosmeticDataSource(this.apiService);

  @override
  Future<List<CosmeticEntity>> getCosmetics() async {
    final cosmetics = await apiService.getCosmetics();
    return cosmetics.map((cosmetic) => CosmeticEntity(
      id: cosmetic.id,
      name: cosmetic.name,
      priceTg: cosmetic.priceTg,
      description: cosmetic.description,
      imageUrl: cosmetic.imageUrl,
    )).toList();
  }
}