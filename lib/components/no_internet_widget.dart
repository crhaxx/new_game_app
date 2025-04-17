import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircularProgressIndicator(),
          Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4_sharp,
            size: 80,
          ),
          SizedBox(
            height: 5,
          ),
          Text("No internet connection"),
        ],
      ),
    );
  }
}
