import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall/screens/auth_screens/log_in_view.dart';
import 'package:the_wall/screens/home_screen/home_view.dart';

class CoreView extends StatefulWidget {
  const CoreView({super.key});

  @override
  State<CoreView> createState() => _CoreViewState();
}

class _CoreViewState extends State<CoreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return  HomeView();
          }
          else{
            return const LogInView();
          }
        },
      ),
    );
  }
}