import 'package:flutter/material.dart';
import 'package:the_wall/components/comment_button.dart';
import 'package:the_wall/components/delete_btn.dart';
import 'package:the_wall/components/like_btn.dart';
import 'package:the_wall/models/post_model.dart';

class WallPost extends StatelessWidget {
  final Post post;
  final bool isLiked;
  final Function onLikeBtnTap;
  final Function()? onDeleteBtnTap;
  

  WallPost({required this.post, required this.isLiked, required this.onLikeBtnTap, required this.onDeleteBtnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(post.userEmail, style: TextStyle(color: Colors.grey[500])),
                  DeleteBtn(onTap: onDeleteBtnTap)
                ],
              ),
              const SizedBox(height: 10,),
              Text(post.postMessage),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
            children: [
              LikeBtn(
                isLiked: isLiked,
                onTap: () => onLikeBtnTap(),
              ),
              Text(post.likes.isEmpty ? "0" : post.likes.length.toString()),
            ],
          ),
          const SizedBox(width: 15,),
          Column(
            children: [
              CommentButton(
                onTap: () {}
                ),
              Text(post.comments.isEmpty ? "0" : post.comments.length.toString())
            ],
          ),
            ],
          )
        ],
      ),
    );
  }
}
