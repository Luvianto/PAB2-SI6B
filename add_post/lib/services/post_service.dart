import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:add_post/models/post_model.dart';

class PostService {
  final CollectionReference _postCollection =
      FirebaseFirestore.instance.collection('posts');

  Stream<List<Post>> getPosts() {
    return _postCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
