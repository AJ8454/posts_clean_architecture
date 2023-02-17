import 'package:posts_clean_architecture/features/posts/data/models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future cachePosts(List<PostModel> postModel);
}

class PostLocalDataSourceImpl implements PostLocalDataSource{
  @override
  Future cachePosts(List<PostModel> postModel) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}