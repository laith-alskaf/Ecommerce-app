import 'package:dartz/dartz.dart';
import 'package:simple_e_commerce/core/error/exceptions.dart';
import 'package:simple_e_commerce/core/error/failure.dart';
import 'package:simple_e_commerce/core/network/network_info.dart';
import 'package:simple_e_commerce/data/datasources/categories/category_remote_datasource.dart';
import 'package:simple_e_commerce/domain/entities/category_entity.dart';
import 'package:simple_e_commerce/domain/repositories/category_repository.dart';
// CategoryModel is not directly returned by the repository, but the datasource returns it.
// The repository's job is to return CategoryEntity. Since CategoryModel extends CategoryEntity,
// it can be returned directly if no further transformation is needed.

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  // final CategoryLocalDataSource localDataSource; // If you had local caching
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getAllCategories();
        return Right(remoteCategories);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      } on NetworkException catch (e) {
        return Left(OfflineFailure(message: e.message ?? 'Network Error'));
      }
    } else {
      return Left(OfflineFailure(message: "No internet connection."));
    }
  }

  // Example for another method if it were defined in CategoryRepository:
  // @override
  // Future<Either<Failure, CategoryEntity>> getCategoryById(String id) async {
  //   // ... implementation ...
  // }
}