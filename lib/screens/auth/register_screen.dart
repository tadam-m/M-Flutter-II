import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:techno_clubs_berlin/API/api_manager.dart';
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
  final ApiManager _apiProvider = ApiManager(client: http.Client());
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> register() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      Get.snackbar('Error', 'All information are mandatory');
      return;
    }
    await _apiProvider
        .registerUser(_usernameController.text, _passwordController.text)
        .then((value) => {
              Get.snackbar('Register Success', 'Register as : ' + value.name),
              setState(() {
                _isLoading = false;
              }),
              Get.offNamed(vueListClub),
            })
        .onError((error, stackTrace) => {
              log(error.toString()),
              setState(() {
                _isLoading = false;
              }),
              Get.snackbar('Register failed', error.toString()),
            });
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
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        key: const Key('usernameRegister'),
                                        controller: _usernameController,
                                        decoration: const InputDecoration(
                                            labelText: 'Username'),
                                        validator: (value) {
                                          if (value == "" || value == null) {
                                            return "Username is required";
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                            key: const Key('emailRegister'),
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                                labelText: 'Email'),
                                            validator: (value) {
                                              if (value == "" ||
                                                  value == null) {
                                                return "Email is required";
                                              }
                                            }),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          key: const Key('passwordRegister'),
                                          controller: _passwordController,
                                          decoration: const InputDecoration(
                                              labelText: 'Password'),
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
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                ElevatedButton(
                                  key: const Key('register'),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      register();
                                    }
                                  }, //signIn,

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
