import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_wall/models/comment.dart';

class Post {
  final String userEmail;
  final String postMessage;
  final Timestamp date;
  final List<String> likes;
  final String docName;
  final List<Comment> comments;

  Post({
    required this.userEmail,
    required this.postMessage,
    required this.date,
    required this.likes,
    required this.docName,
    required this.comments
  });

  factory Post.fromFirestore(Map<String, dynamic> data) {
    return Post(
      userEmail: data['email'], 
      postMessage: data['message'],
      date: data['timestamp'] as Timestamp, 
      likes: List<String>.from(data['listOfLikes']),
      docName: data['docName'],
      comments:  List<Comment>.from(data['comments'])
    );
  }

  void addLike(String userId) {
    if (!likes.contains(userId)) {
      likes.add(userId);
    }
  }
}
