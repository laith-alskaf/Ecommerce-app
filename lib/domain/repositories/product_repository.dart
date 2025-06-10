import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ({List<ProductEntity> products, int totalPage})>> getAllProducts();
}