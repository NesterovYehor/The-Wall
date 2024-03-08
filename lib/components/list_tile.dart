import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  MyListTile({Key? key, required this.icon, required this.title, required this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the onTap function here
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
