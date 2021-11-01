import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
