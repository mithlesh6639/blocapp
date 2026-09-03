import '../../models/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final Post? selectedPost;
  PostLoaded(this.posts, {this.selectedPost});

  PostLoaded copyWith({
    List<Post>? posts,
    Post? selectedPost,
  }) {
    return PostLoaded(
      posts ?? this.posts,
      selectedPost: selectedPost ?? this.selectedPost,
    );
  }
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}

class PostCreated extends PostState {
  final Post post;
  PostCreated(this.post);
}
