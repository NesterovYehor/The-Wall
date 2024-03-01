import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/screens/auth_screens/log_in_view.dart';
import 'package:the_wall/screens/home_screen/home_view.dart';

class CoreView extends StatelessWidget {
  const CoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return const HomeView();
          }
          else{
            return LogInView();
          }
        },
      ),
    );
  }
}