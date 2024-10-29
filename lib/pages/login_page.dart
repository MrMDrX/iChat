import 'package:flutter/material.dart';
import 'package:ichat/auth/auth_service.dart';
import 'package:ichat/widgets/app_button.dart';
import 'package:ichat/widgets/app_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void login() async {
    final AuthService authService = AuthService();
    try {
      if (_emailController.text.isEmpty || _pwdController.text.isEmpty) {
        throw Exception('Please fill in email and password');
      }
      await authService.signIn(_emailController.text, _pwdController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_rounded,
              size: 76,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'iChat',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Welcome back, you\'ve been missed!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            AppTextfield(
              hintText: 'Email',
              controller: _emailController,
              obscureText: false,
            ),
            const SizedBox(height: 16),
            AppTextfield(
              hintText: 'Password',
              controller: _pwdController,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            AppButton(text: 'Login', onTap: login),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ?"),
                TextButton(
                  onPressed: widget.onPressed,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
