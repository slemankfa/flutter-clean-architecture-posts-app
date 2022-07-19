import 'package:clean_arch_posts_app/core/network/network_info.dart';
import 'package:clean_arch_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_arch_posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_arch_posts_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_arch_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_arch_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! features - post

  // BLOC

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePosts: sl(),
      updatePosts: sl(),
    ),
  );

  // USECASES

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostsUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // DataSources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
