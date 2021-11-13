import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            TextFormField(
              key: const Key('usernameRegister'),
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == "" || value == null) {
                  return "Username is required";
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                  key: const Key('emailRegister'),
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == "" || value == null) {
                      return "Email is required";
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                key: const Key('passwordRegister'),
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Password is required";
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
