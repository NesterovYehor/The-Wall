import 'package:flutter/material.dart';

class DeleteBtn extends StatelessWidget {
  const DeleteBtn({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.delete, color: Colors.grey,),
    );
  }
}