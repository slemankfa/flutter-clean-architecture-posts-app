import 'package:clean_arch_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_arch_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class UpdatePostsUseCase {
  final PostRepository repository;

  UpdatePostsUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
