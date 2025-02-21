import 'package:flutter/material.dart';
import 'package:new_game_app/pages/about_page.dart';

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
                  "New Game App",
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
                style: TextStyle(color: Colors.grey.shade900),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.grey.shade900,
              ),
              onTap: () => Navigator.pop(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 0),
            child: ListTile(
              title: Text(
                "ABOUT",
                style: TextStyle(color: Colors.grey.shade900),
              ),
              leading: Icon(
                Icons.info,
                color: Colors.grey.shade900,
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
