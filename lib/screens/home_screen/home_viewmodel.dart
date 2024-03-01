import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/post_model.dart';

class HomeViewModel extends ChangeNotifier {
  final textController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('User Posts');

  Stream<List<Post>> getPosts() {
    return postCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Post.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> likeFunc(Post post) async{
        // Update Firestore with the new list of likes
        postCollection
            .doc(post.) // Assuming documentId is the Firestore document ID of the post
            .update({'listOfLikes': post.likes})
            .then((_) {
          print('Likes updated successfully');
        }).catchError((error) {
          print('Failed to update likes: $error');
        });
      }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> postMessage() async {
    try {
      if (textController.text.isNotEmpty) {
        await postCollection.add({
          'email': currentUser?.email ?? 'Unknown',
          'message': textController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'listOfLikes' : [], // Firestore server timestamp
        });
        textController.clear();
      }
    } catch (e) {
      print('Error posting message: $e');
    }
  }
}
