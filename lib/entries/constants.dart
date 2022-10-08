// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_storage/firebase_storage.dart';

// // final _firestore = Firestore.instance;
// // final storageRef = FirebaseStorage.instance.ref();
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:pixeltech/Body/Onboard/screens/signup_screen.dart';

// final usersRef = Firestore.instance.collection('users');
// final StorageReference storageRef = FirebaseStorage.instance.ref();
// final postsRef = Firestore.instance.collection('posts');
// // final postsRef = _firestore.collection('posts');
// // final followersRef = _firestore.collection('followers');
// // final followingRef = _firestore.collection('following');
// // final feedsRef = _firestore.collection('feeds');
// // final likesRef = _firestore.collection('likes');
// final commentsRef = Firestore.instance.collection('comments');
// final activityFeedRef = Firestore.instance.collection('activities');

import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_storage/firebase_storage.dart';
//final storageRef = FirebaseStorage.instance.ref();
final _firestore = FirebaseFirestore.instance;

final ItemRef = _firestore.collection('feeds');
final entryRef = _firestore.collection('posts');

final usersRef = _firestore.collection('users');
final bioRef = _firestore.collection('bios');
final followersRef = _firestore.collection('followers');
final followingRef = _firestore.collection('following');
//final feedsRef = _firestore.collection('feeds');
final likesRef = _firestore.collection('likes');
final commentsRef = _firestore.collection('comments');
final activitiesRef = _firestore.collection('activities');

final contestRef = _firestore.collection('contests');
