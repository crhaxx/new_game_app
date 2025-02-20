import "package:flutter/material.dart";

class CreategamePage extends StatefulWidget {
  const CreategamePage({super.key});

  @override
  State<CreategamePage> createState() => _CreategamePageState();
}

class _CreategamePageState extends State<CreategamePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Game"),
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}
