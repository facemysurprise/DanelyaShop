import 'package:flutter_nd/data/models/dataproduct_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'dataproduct_repository.g.dart';

@RestApi(baseUrl: "https://ndpro-3e160-default-rtdb.firebaseio.com/")
abstract class CosmeticApiService {
  factory CosmeticApiService(Dio dio, {String baseUrl}) = _CosmeticApiService;

  @GET("/cosmetics.json")
  Future<List<Cosmetic>> getCosmetics();
}