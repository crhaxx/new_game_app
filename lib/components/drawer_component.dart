import 'package:flutter/material.dart';
import 'package:Gamebuddy/pages/about_page.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Column(
        children: [
          Container(
            height: 150,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: Center(
                child: Text(
                  "Gamebuddy",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 15),
            child: ListTile(
              title: Text(
                "HOME",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 0),
            child: ListTile(
              title: Text(
                "HISTORY",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              leading: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 0),
            child: ListTile(
              title: Text(
                "ABOUT",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              leading: Icon(
                Icons.info,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutPage())),
            ),
          ),
        ],
      ),
    );
  }
}
