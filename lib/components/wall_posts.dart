import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:the_wall/components/like_btn.dart';
import 'package:the_wall/models/post_model.dart';

class WallPost extends StatelessWidget {
   WallPost({super.key, required this.post, required this.isLiked, required this.onTap});

  final Post post;
  final Bool isLiked;
  void onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
        ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              LikeBtn(
                isLiked: false, 
                onTap: () => onTap
                ),
                Text(post.likes.length.toString())
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.userEmail, style: TextStyle(color: Colors.grey[500])),
              Text(post.postMessage),
            ],
          ),
        ],
      ),
    );
  }
}