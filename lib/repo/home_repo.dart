import 'package:practice_test/models/product_model.dart';
import 'package:practice_test/repo/api_fetch.dart';

class HomeRepo  {
  final NetWorkApiService _apiServices = NetWorkApiService();

  Future<ProductModel> getUserProfile(
    ) async {
    try {
      dynamic response = await _apiServices.getProductspiResponse(
          'https://dummyjson.com/products', );
      return response = ProductModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}