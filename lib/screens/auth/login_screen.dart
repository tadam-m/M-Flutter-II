import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:techno_clubs_berlin/components/auth/login_form.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please verify your informations');
      return;
    }

    Map data = {
      'email': _emailController.text,
      'password': _passwordController.text
    };

    var response = await http.post("YOUR_BASE_URL", body: data);
    if(response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if(jsonResponse) {
        setState(() {
          _isLoading = false;
        });
        log ("Login succeffuly ! ");
        Get.snackbar('Login Success', 'logged in as');
      }
    } else {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar('Login failed', 'wrong credentials');
        log(response.body);
    }
  }

 /* void login() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please verify your informations');
      return;
    }
*//*    User? user = userController.login(
      _emailController.text,
      _passwordController.text,
    );
    if (user == null) {
      Get.snackbar('Login failed', 'wrong credentials');
    } else {
      Get.snackbar('Login Success', 'logged in as ${user.name}');*//*
      // Get.offNamed(homeRoute);
    //}
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
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
                        child: LoginForm(
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
                              //onPressed: login,
                              child: const Text('Login'),
                            ),
                            ElevatedButton(
                              onPressed: () => Get.offNamed(registerRoute),
                              child: const Text('No account ? Go to register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}