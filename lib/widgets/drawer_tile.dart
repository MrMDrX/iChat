import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final void Function()? onTap;
  const DrawerTile(
      {super.key, required this.title, required this.leading, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 2),
        ),
        leading: Icon(
          leading,
          color: Theme.of(context).colorScheme.inversePrimary,
          size: 32,
        ),
        onTap: onTap,
      ),
    );
  }
}
