// ignore_for_file: prefer_const_constructors

import 'package:chat_app_demo/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        title: Padding(
          padding: const EdgeInsets.only(left: 93.0),
          child: Text("Settings"),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode
            Text("Dark Mode"),
        
            //switch toggle
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
