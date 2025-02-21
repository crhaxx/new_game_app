import "package:flutter/material.dart";

class CreategamePage extends StatefulWidget {
  const CreategamePage({super.key});

  @override
  State<CreategamePage> createState() => _CreategamePageState();
}

class _CreategamePageState extends State<CreategamePage> {
  int currentPageIndex = 0;

  void createGame() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Game"),
        centerTitle: true,
      ),
      body: Center(
        child:
            ElevatedButton(onPressed: createGame, child: Text("Create Game")),
      ),
    );
  }
}
