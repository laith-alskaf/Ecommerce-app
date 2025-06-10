import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_e_commerce/app/my_app_cubit.dart';
import 'package:simple_e_commerce/core/data/repositories/storage_repositories.dart';
import 'package:simple_e_commerce/core/network/network_info.dart';
import 'package:simple_e_commerce/core/services/notification_service.dart';
import 'package:simple_e_commerce/core/utils/network_utils.dart';
import 'package:simple_e_commerce/data/datasources/auth/remote/auth_remote_datasource.dart';
import 'package:simple_e_commerce/data/datasources/auth/remote/auth_remote_datasource_impl.dart';
import 'package:simple_e_commerce/data/datasources/categories/category_remote_datasource.dart';
import 'package:simple_e_commerce/data/datasources/categories/category_remote_datasource_impl.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource.dart';
import 'package:simple_e_commerce/data/datasources/products/product_remote_datasource_impl.dart';
import 'package:simple_e_commerce/data/repositories/auth_repository_impl.dart';
import 'package:simple_e_commerce/data/repositories/category_repository_impl.dart';
import 'package:simple_e_commerce/data/repositories/produc_repository_impl.dart';
import 'package:simple_e_commerce/domain/repositories/auth_repository.dart';
import 'package:simple_e_commerce/domain/repositories/category_repository.dart';
import 'package:simple_e_commerce/domain/repositories/product_repository.dart';
import 'package:simple_e_commerce/domain/usecases/auth/login_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/sendcode_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/signup_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/auth/verify_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/category/get_all_categories_usecase.dart';
import 'package:simple_e_commerce/domain/usecases/product/get_all_product_usecase.dart';
import 'package:simple_e_commerce/firebase_options.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/login/login_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/auth/signup/signup_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/category/categories_cubit.dart';
import 'package:simple_e_commerce/core/services/connectivity_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_e_commerce/presentation/controllers/main/main_cubit.dart';
import 'package:simple_e_commerce/presentation/controllers/products/products_cubit.dart';
import 'package:get/get.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await registerSharedPreferences();
  initServiceLocator();
  registerUseCases();
  registerCubits();
  registerDataSources();
  registerRepositories();
  await registerExternalDependencies();
}

Future<void> registerSharedPreferences() async {
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferenceRepositories>(
    () => SharedPreferenceRepositories(globalSharedPreferences: sharedPref),
  );
  Get.put(SharedPreferenceRepositories(globalSharedPreferences: sharedPref));
}

registerUseCases() {
  // UseCases
  sl.registerLazySingleton<GetAllCategoriesUsecase>(
    () => GetAllCategoriesUsecase(sl()),
  );
  sl.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(sl()),
  );
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyUsecase(sl()));
  sl.registerLazySingleton(() => SendCodeUseCase(sl()));
}

registerRepositories() {
  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      // localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      // localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
}

registerDataSources() {
  // Datasource
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(networkUtil: sl()),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(networkUtil: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(networkUtil: sl()),
  );
}

initServiceLocator() async {
  // Services && Core
  sl.registerLazySingleton(() => NetworkUtil());
  sl.registerLazySingleton(() => ConnectivityService());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => NotificationService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

Future<void> registerExternalDependencies() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    (e);
  }
}

registerCubits() {
  // Cubits/Blocs (usually registered as factory because they hold state)
  sl.registerLazySingleton(() => MyAppCubit());
  sl.registerLazySingleton(() => MainCubit());
  sl.registerLazySingleton(() => LoginCubit(sl()));
  sl.registerLazySingleton(() => SignUpCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(
    () => CategoriesCubit(getAllCategoriesUsecase: sl()),
  );
  sl.registerLazySingleton(() => ProductsCubit(getAllProductsUseCase: sl()));
}
