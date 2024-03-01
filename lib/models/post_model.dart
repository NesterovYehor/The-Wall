import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userEmail;
  final String postMessage;
  final Timestamp date;
  final List<String> likes;

  Post({
    required this.userEmail,
    required this.postMessage,
    required this.date,
    required this.likes
  });

  factory Post.fromFirestore(Map<String, dynamic> data) {
    return Post(
      userEmail: data['email'], 
      postMessage: data['message'],
      date: data['timestamp'], 
      likes: data['likes']
    );
  }

  void addLike(String userId) {
    if (!likes.contains(userId)) {
      likes.add(userId);
    }
  }
}
