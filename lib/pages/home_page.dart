import 'package:flutter/material.dart';
import 'package:ichat/services/auth/auth_service.dart';
import 'package:ichat/services/chat/chat_service.dart';
import 'package:ichat/widgets/drawer.dart';
import 'package:ichat/widgets/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('iChat'),
          centerTitle: true,
        ),
        drawer: const AppDrawer(),
        body: _buildUsersList(context));
  }

  Widget _buildUsersList(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No users found'));
        }
        if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final user = snapshot.data![index];
            return user['email'] == _authService.currentUser!.email
                ? const SizedBox.shrink()
                : UserTile(
                    username: user['email'],
                    onTap: () {},
                  );
          },
        );
      },
    );
  }
}
