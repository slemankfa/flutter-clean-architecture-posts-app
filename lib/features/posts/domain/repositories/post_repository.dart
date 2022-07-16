import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}
