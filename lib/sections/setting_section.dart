import "package:Gamebuddy/theme/theme_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.light),
                SizedBox(width: 15),
                Text("Dark Mode"),
                SizedBox(width: 75),
                Switch(
                    value: isDark,
                    onChanged: (value) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
