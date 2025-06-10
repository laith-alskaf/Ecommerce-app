import 'dart:io';

import 'package:simple_e_commerce/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<({List<ProductModel> products, int totalPages})> getAllProducts({
    int page = 1,
    int limit = 10,
  });

  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
  });

  Future<List<ProductModel>> searchProduct({
    required String title,
    int page = 1,
    int limit = 10,
  });

  Future<List<ProductModel>> getProductsMine({int page = 1, int limit = 10});

  Future<List<ProductModel>> createProduct({
    required Map<String, dynamic> product,
    required File image,
  });

  Future<List<ProductModel>> deleteProduct({required String productId});
}
