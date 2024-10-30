import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatBubble({super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSender
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
