import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wall/components/text_box.dart';
import 'package:the_wall/screens/profile_screen/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProfileView({Key? key, required String email});
  @override
  Widget build(BuildContext context) {
  return Consumer<ProfileViewModel>(
    builder: (context, vm, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("P R O F I L E"),
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Icon(Icons.person, size: 72,),
              ),
              Text(vm.currentUser!.email!),
              StreamBuilder<DocumentSnapshot<Object?>>(
                stream: vm.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final userData = snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        MyTextBox(
                          title: "username",
                          text: userData["username"],
                          onTap: () => vm.editField("username", context),
                        ),
                        MyTextBox(
                          title: "email",
                          text: userData["email"],
                          onTap: () {},
                        ),
                      ],
                    );
                  } else if (snapshot.hasError && snapshot.error != null) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                }
              ),
            ],
          ),
        ),
      );
    },
  );
  }
  
}

