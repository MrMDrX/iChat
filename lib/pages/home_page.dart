import 'package:flutter/material.dart';
import 'package:ichat/auth/auth_service.dart';
import 'package:ichat/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() async {
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iChat'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text('HomePage'),
      ),
    );
  }
}
