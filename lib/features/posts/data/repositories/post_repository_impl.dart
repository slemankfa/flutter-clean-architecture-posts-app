import 'package:clean_arch_posts_app/core/error/exceptions.dart';
import 'package:clean_arch_posts_app/core/network/network_info.dart';
import 'package:clean_arch_posts_app/features/posts/data/models/post_model.dart';
import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/core/error/failures.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef DeleteOraddOrUpdatePost = Future<Unit> Function();
// typedef Future<Unit> DeleteOraddOrUpdatePost();

class PostsRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachPosts(remotePosts);
        return Right(remotePosts);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPost();
        return Right(localPosts);
      } on EmptyCashExceptions {
        return Left(EmptyCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOraddOrUpdatePost deleteOraddOrUpdatePost) async {
    if (await networkInfo.isConnected) {
      try {
        // await remoteDataSource.deletePost(postId);
        await deleteOraddOrUpdatePost();
        return const Right(unit);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
