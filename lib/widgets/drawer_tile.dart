import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final void Function()? onTap;
  const DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24.0),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 2),
        ),
        leading: Icon(
          color: Theme.of(context).colorScheme.primary,
          leading,
          size: 32,
        ),
        onTap: onTap,
      ),
    );
  }
}
