import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wall/screens/auth_screens/log_in_view.dart';
import 'package:the_wall/screens/auth_screens/sign_up_view.dart';
import 'package:the_wall/screens/auth_screens/auth_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_wall/screens/core_screen.dart';
import 'package:the_wall/screens/home_screen/home_view.dart';
import 'package:the_wall/screens/home_screen/home_viewmodel.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CoreView(),   
        routes: {
          '/signup' :(context) => SignUpView(),
          '/login' :(context) => LogInView(),
          '/home' :(context) => HomeView(),
        },
      )
    );
  }
}