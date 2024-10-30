import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichat/services/auth/auth_service.dart';
import 'package:ichat/services/chat/chat_service.dart';
import 'package:ichat/widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _msgController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    String msg = _msgController.text;
    if (msg.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverId, msg);
      _msgController.clear();
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail.split('@')[0]),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildMessageList(),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Expanded(
      child: StreamBuilder(
        stream: _chatService.getMessagesStream(
          _authService.currentUser!.uid,
          widget.receiverId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No messages yet'));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                return _buildMessageItem(doc);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isSender = data['senderId'] == _authService.currentUser!.uid;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            data['senderEmail'].split('@')[0],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              ChatBubble(message: data['message'], isSender: isSender)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _msgController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward_rounded, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}
