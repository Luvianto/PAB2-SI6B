import 'package:firebase_auth/firebase_auth.dart';
import 'package:add_post/screens/add_post_screen.dart';
import 'package:add_post/models/post_model.dart';
import 'package:add_post/services/post_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PostService _postService = PostService();

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<List<Post>>(
        stream: _postService.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            return const Center(child: Text('Belum ada postingan'));
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];

              return ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(post.description.length > 32
                    ? '${post.description.substring(0, 32)}...'
                    : post.description),
                subtitle: Text(
                  "Kategori: ${post.category}",
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPostScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
