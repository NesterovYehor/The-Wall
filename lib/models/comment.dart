import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  final String commentText;
  final String commentedBy;
  final Timestamp commentTime;

  Comment({
    required this.commentText,
    required this.commentedBy,
    required this.commentTime,
  });

  
}