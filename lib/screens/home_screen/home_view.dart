import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wall/components/drawer.dart';
import 'package:the_wall/components/text_field.dart';
import 'package:the_wall/components/wall_posts.dart';
import 'package:the_wall/models/post_model.dart';
import 'package:the_wall/screens/home_screen/home_viewmodel.dart';

class HomeView extends StatefulWidget {
   HomeView({Key? key});
  
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(

          title: const Text("T H E   W A L L"), 
          actions: [
            IconButton(
              onPressed: () => vm.logOut(),
              icon: const Icon(Icons.logout, color: Colors.black),
            )
          ],
        ),
        drawer: MyDrawer(
          onProfileTap: () => vm.goToProfilePage(context),
          onSignOut: () => vm.logOut(),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Post>>(
                  stream: vm.getPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      List<Post> posts = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return WallPost(
                            post: posts[index], 
                            isLiked: vm.isLiked(posts[index]), 
                            onLikeBtnTap: () => vm.likeBtnFunc(posts[index]), 
                            onDeleteBtnTap: () => vm.deletePost(context, posts[index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: vm.textController,
                        hintText: "Write something on the wall",
                        obscureText: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () => vm.postMessage(),
                        icon: const Icon(Icons.arrow_circle_up, size: 30),
                      ),
                    )
                  ],
                ),
              ),
              Text("Logged in as ${vm.currentUser?.email ?? 'Unknown'}", style: const TextStyle(color: Colors.grey),),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
