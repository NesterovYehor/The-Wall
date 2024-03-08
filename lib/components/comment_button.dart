import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentButton extends StatelessWidget {
   CommentButton({super.key, required this.onTap});

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.comment, color: Colors.grey,),
    );
  }
}