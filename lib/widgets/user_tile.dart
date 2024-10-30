import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String username;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.username,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              username.split('@')[0],
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
