import 'package:flutter/material.dart';
import 'package:the_wall/components/list_tile.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key, required this.onProfileTap, required this.onSignOut});

  final VoidCallback onProfileTap;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const DrawerHeader(
                    child: Icon(Icons.person, color: Colors.white, size: 64,),
                  ),
                  MyListTile(
                      icon: Icons.home,
                      title: "H O M E",
                      onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                    ),
                  MyListTile(
                    icon: Icons.person,
                    title: "P R O F I L E",
                    onTap: onProfileTap,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: MyListTile(
                  icon: Icons.logout,
                  title: "L O G O U T",
                  onTap: onSignOut,
                ),
              )
            ],
          ),
        ),
      );
  }
}
