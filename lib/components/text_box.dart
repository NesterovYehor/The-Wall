import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({super.key, required this.title, required this.text, required this.onTap});

  final String title;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[500]),),
              IconButton(onPressed: onTap, icon: Icon(Icons.settings, color: Colors.grey[400],))
            ],
          ),
          Text(text),
        ],
      )
    );
  }
}
