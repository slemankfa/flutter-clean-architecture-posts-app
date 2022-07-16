import 'package:clean_arch_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPost();
  Future<Unit> cachPosts(List<PostModel> postModels);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  @override
  Future<Unit> cachPosts(List<PostModel> postModels) {
    // TODO: implement cachPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    // TODO: implement getCachedPost
    throw UnimplementedError();
  }
}
