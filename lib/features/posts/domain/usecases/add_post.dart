import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class AddPostsUseCase {
  final PostRepository repository;

  AddPostsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
