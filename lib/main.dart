import 'package:flutter/material.dart';
import 'package:ichat/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iChat',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('iChat'),
        ),
        body: const Center(
          child: Text('Welcome to iChat !'),
        ),
      ),
    );
  }
}
