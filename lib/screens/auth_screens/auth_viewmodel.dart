import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier{
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

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
}
