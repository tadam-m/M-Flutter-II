import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:techno_clubs_berlin/components/auth/register_form.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  // final UserController userController = Get.find<UserController>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void register() {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      Get.snackbar('Error', 'All information are mandatory');
      return;
    }
 /*   final User _user = User(
      name: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    userController.create(_user);
    Get.snackbar('Login Success', 'logged in as ${_user.name}');
    userController.login(_emailController.text, _passwordController.text);
    Get.offAllNamed(homeRoute);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) =>
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Welcome\non\nTechno Clubs Berlin',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: RegisterForm(
                            usernameController: _usernameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () => log('data: Pressed Button 1'),
//                                onPressed: register,
                                child: const Text('Register'),
                              ),
                              ElevatedButton(
                                onPressed: () => Get.offNamed(loginRoute),
                                child: const Text(
                                  'Already have an account ? Go to login',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}