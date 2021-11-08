import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:techno_clubs_berlin/API/api_manager.dart';

import 'package:techno_clubs_berlin/components/auth/register_form.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> register() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      Get.snackbar('Error', 'All information are mandatory');
      return;
    }
    await ApiManager()
        .registerUser(_emailController.text, _passwordController.text)
        .then((value) {
      Get.snackbar('Register Success', 'Register as : ' + value.name);
      setState(() {
        _isLoading = false;
      });
    }).onError((error, stackTrace) {
      log(error.toString());
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Register failed', error.toString());
    });
    /* Get.offAllNamed(homeRoute);*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) =>
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
                              'Register\nto\nGehen Sie zum Club',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 35.0),
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
                                  onPressed: register,
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
