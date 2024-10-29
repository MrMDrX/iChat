import 'package:flutter/material.dart';
import 'package:ichat/auth/auth_service.dart';

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
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('HomePage'),
      ),
    );
  }
}
