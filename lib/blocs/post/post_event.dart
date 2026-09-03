import '../../models/post.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class CreatePost extends PostEvent {
  final String title;
  final String body;
  CreatePost(this.title, this.body);
}

class SelectPost extends PostEvent {
  final Post post;
  SelectPost(this.post);
}
