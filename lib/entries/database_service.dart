import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative/entries/post_model.dart';

import 'constants.dart';

class DatabaseService {
  static Future<List<Post>> getItemPosts() async {
    QuerySnapshot ItemSnapshot = await ItemRef.doc("Wordpress")
        .collection('userFeed')
        .orderBy('timestamp', descending: true)
        .get();
    List<Post> posts =
        ItemSnapshot.docs.map((doc) => Post.fromDoc(doc)).toList();
    return posts;
  }

  static void entryPost(Post post) {
    entryRef.doc().collection("Wordpress").add({
      'imageUrl': post.imageUrl,
      'caption': post.name,
      'downloadCount': post.downloadCount,
      'timestamp': post.timestamp,
    });
  }
}
