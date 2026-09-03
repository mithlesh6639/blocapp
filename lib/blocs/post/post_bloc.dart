import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post.dart';
import '../../repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

export 'post_event.dart';
export 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await postRepository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

    on<CreatePost>((event, emit) async {
      final currentState = state;
      if (currentState is PostLoaded) {
        try {
          final newPost = await postRepository.createPost(event.title, event.body);
          // Simulate persistence by adding to the current list
          final updatedPosts = List<Post>.from(currentState.posts)..insert(0, newPost);
          emit(PostCreated(newPost)); // Temporary state to trigger UI notification
          emit(PostLoaded(updatedPosts, selectedPost: currentState.selectedPost)); 
        } catch (e) {
          emit(PostError(e.toString()));
          emit(PostLoaded(currentState.posts, selectedPost: currentState.selectedPost)); 
        }
      }
    });

    on<SelectPost>((event, emit) {
      final currentState = state;
      if (currentState is PostLoaded) {
        emit(currentState.copyWith(selectedPost: event.post));
      }
    });
  }
}
