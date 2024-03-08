import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LikeBtn extends StatelessWidget {
  LikeBtn({super.key, required this.isLiked, required this.onTap});

  final bool isLiked;
  void Function()? onTap;
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: isLiked ? Colors.red : Colors.grey,),
    );
  }
}