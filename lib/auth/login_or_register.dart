import 'package:flutter/material.dart';
import 'package:ichat/pages/login_page.dart';
import 'package:ichat/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isLogin = true;

  void togglePage() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginPage(
            onPressed: togglePage,
          )
        : RegisterPage(
            onPressed: togglePage,
          );
  }
}
