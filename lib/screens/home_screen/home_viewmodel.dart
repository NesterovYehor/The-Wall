import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/screens/profile_screen/profile_view.dart';
import 'package:uuid/uuid.dart';

import '../../models/post_model.dart';

class HomeViewModel extends ChangeNotifier {
  final textController = TextEditingController();
  final commentTextController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final CollectionReference postCollection = FirebaseFirestore.instance.collection('User Posts');

  Stream<List<Post>> getPosts() {
    return postCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Post.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> likeBtnFunc(Post post) async {
    try {
      if (post.likes.contains(currentUser!.uid)) {
        post.likes.remove(currentUser!.uid);
        await postCollection.doc(post.docName).update({
          'listOfLikes': post.likes,
        });
        notifyListeners();
      } else {
        post.likes.add(currentUser!.uid);
        await postCollection.doc(post.docName).update({
          'listOfLikes': post.likes,
        });
        notifyListeners();
      }
    } catch (e) {
      print('Error adding user like: $e');
    }
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
        var id = Uuid().v4();
        await postCollection.doc(id).set({
          'email': currentUser?.email ?? 'Unknown',
          'message': textController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'listOfLikes' : [],
          'docName' : id, 
          'comments' : []
        });
        textController.clear();
      }
    } catch (e) {
      print('Error posting message: $e');
    }
  }

  bool isLiked(Post post) {
    if (post.likes.contains(currentUser!.uid)) {
      return true;
    } else {
      print(post.likes);
      return false;
    }
  }

  void goToProfilePage(BuildContext context){
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileView(
          email: currentUser?.email ?? 'Unknown')
      )
    );
  }

  void addComment(String commentText, Post post) {
    postCollection.doc(post.docName).collection("comments").add({
      "commentText": commentText,
      "commentedBy": currentUser!.email,
      "commentTime": FieldValue.serverTimestamp()
    });
  } 

  void deletePost(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure you want to delete this post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              postCollection.doc(post.docName).delete();
              Navigator.pop(context); // Close the dialog after deleting
            }, 
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }


  //  void showCommentDialog(BuildContext context, Post post) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         backgroundColor: Colors.white,
  //         title: Text("Add comment"),
  //         content: TextField(
  //           autocorrect: true,
  //           controller: _commentTextController,
  //           style: TextStyle(color: Colors.white),
  //           decoration: InputDecoration(
  //             hintText: "Enter new comment",
  //             hintStyle: TextStyle(color: Colors.grey)
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Dismiss the dialog
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               addComment(_commentTextController.text, post);
  //               Navigator.pop(context); // Dismiss the dialog
  //               notifyListeners(); // Notify listeners to rebuild UI
  //             },
  //             child: Text("Comment"),
  //           ),
  //         ],
  //       ),
  //     );
  //   }



}
