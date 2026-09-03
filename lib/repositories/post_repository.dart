import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    developer.log('GET Request: $apiUrl', name: 'PostRepository');
    try {
      final response = await http.get(Uri.parse(apiUrl));
      developer.log('Response Status: ${response.statusCode}', name: 'PostRepository');
      developer.log('Response Body: ${response.body}', name: 'PostRepository');

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Error fetching posts: $e', name: 'PostRepository', error: e);
      rethrow;
    }
  }

  Future<Post> createPost(String title, String body) async {
    final requestBody = jsonEncode(<String, dynamic>{
      'title': title,
      'body': body,
      'userId': 1,
    });

    developer.log('POST Request: $apiUrl', name: 'PostRepository');
    developer.log('Request Body: $requestBody', name: 'PostRepository');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      developer.log('Response Status: ${response.statusCode}', name: 'PostRepository');
      developer.log('Response Body: ${response.body}', name: 'PostRepository');

      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Error creating post: $e', name: 'PostRepository', error: e);
      rethrow;
    }
  }
}
