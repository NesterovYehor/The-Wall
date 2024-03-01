import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wall/components/button.dart';
import 'package:the_wall/components/text_field.dart';
import 'package:the_wall/screens/auth_screens/auth_viewmodel.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Consumer<AuthViewModel>(
        builder: (context, vm, child) => SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50
                    ),
                  const Icon(
                    Icons.lock, 
                    size: 100
                    ),
                  const SizedBox(
                    height: 50
                    ),
                  const Text("Welcome back, you've been missed!"),
                  const SizedBox(height: 25
                  ),
                  MyTextField(
                    controller: vm.emailTextController, 
                    hintText: "Email", 
                    obscureText: false
                    ),
                  const SizedBox(
                    height: 15
                  ),
                  MyTextField(
                    controller: vm.passwordTextController, 
                  hintText: "Password", 
                  obscureText: true
                  ),
                  const SizedBox(
                    height: 15
                    ),
                  MyButton(text: "Sign In", 
                  onTap: () => vm.signIn(context)
                  ),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a member?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup'),
                        child: Text("Register now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}