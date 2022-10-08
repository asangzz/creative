import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageUrl;
  final String name;
  final int downloadCount;
  // final String authorId;
  final Timestamp timestamp;
  // final String author;
  // final String contest;

  Post({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.downloadCount,
    required this.timestamp,
  });

  factory Post.fromDoc(DocumentSnapshot doc) {
    return Post(
        id: doc.id,
        imageUrl: doc['imageUrl'],
        name: doc['name'],
        downloadCount: doc['downloadCount'],
        timestamp: doc['timestamp']);
  }
}
