import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_wall/components/text_field.dart';
import 'package:the_wall/components/wall_posts.dart';
import 'package:the_wall/models/post_model.dart';
import 'package:the_wall/screens/home_screen/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text(
            "T H E   W A L L",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(
              onPressed: () => vm.logOut(),
              icon: Icon(Icons.logout, color: Colors.white),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Post>>(
                  stream: vm.getPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      List<Post> posts = snapshot.data!;
                      return ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return WallPost(post: posts[index], isLiked: posts[index].likes.contains(vm.currentUser) ? true : false);
                        },
                      );
                    } else {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
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
                        icon: Icon(Icons.arrow_circle_up, size: 30),
                      ),
                    )
                  ],
                ),
              ),
              Text("Logged in as ${vm.currentUser?.email ?? 'Unknown'}", style: TextStyle(color: Colors.grey),),
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
