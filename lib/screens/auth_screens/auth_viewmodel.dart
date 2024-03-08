import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


class AuthViewModel extends ChangeNotifier{
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('Users');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void signIn(BuildContext context) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
    }on FirebaseAuthException catch (e) {
      displayMessage(context, e.code);
    }
  }
  void signUp() async{
    if (passwordTextController.text == confirmPasswordTextController.text){
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text);
    }
    if (currentUser != null){
      saveUser();
    }
  }

  void displayMessage(BuildContext context, String message) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        );
      },
    );
  }

    Future<void> saveUser() async {
    try {
      var id = Uuid().v4();
      await userCollection.doc(currentUser?.email ?? id).set({
        'email': currentUser?.email ?? 'Unknown',
        'username': userNameTextController.text,
        });
    } catch (e) {
      print('Error posting message: $e');
    }
  } 
}
