import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wall/components/button.dart';
import 'package:the_wall/components/text_field.dart';
import 'package:the_wall/screens/auth_screens/auth_viewmodel.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
                    const Text("Lets create an account for you"),
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
                      controller: vm.userNameTextController, 
                      hintText: "Username", 
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
                    MyTextField(
                      controller: vm.confirmPasswordTextController, 
                      hintText: "Confirm", 
                      obscureText: true
                    ),
                    const SizedBox(
                      height: 15
                      ),
                    MyButton(text: "Sign In", 
                    onTap: () => vm.signUp()
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/login'),
                          child: Text("Login now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}