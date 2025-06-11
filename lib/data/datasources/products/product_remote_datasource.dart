import 'package:simple_e_commerce/core/params/product/create_product_params.dart';
import 'package:simple_e_commerce/core/params/product/get_product_pagination_params.dart';
import 'package:simple_e_commerce/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<({List<ProductModel> products, int totalPages})> getAllProducts(
    GetProductPaginationParams productPaginationParams,
  );

  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
  });

  Future<List<ProductModel>> searchProduct(
    GetProductPaginationParams productPaginationParams,
  );

  Future<List<ProductModel>> getProductsMine(
    GetProductPaginationParams productPaginationParams,
  );

  Future<String> createProduct({
    required CreateProductParams createProductParams,
  });

  Future<String> deleteProduct({required String productId});
}
