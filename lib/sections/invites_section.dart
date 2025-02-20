import "package:flutter/material.dart";

class InvitesPage extends StatefulWidget {
  const InvitesPage({super.key});

  @override
  State<InvitesPage> createState() => _InvitesPageState();
}

class _InvitesPageState extends State<InvitesPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invites"),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
