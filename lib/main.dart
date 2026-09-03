import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/post/post_bloc.dart';
import 'repositories/post_repository.dart';
import 'ui/post_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Start build UI
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(),
      child: BlocProvider(
        create: (context) => PostBloc(context.read<PostRepository>())..add(FetchPosts()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter BLoC Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const PostListScreen(),
        ),
      ),
    );
  }
}
