import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiManager _apiProvider = ApiManager(client: http.Client());
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  signIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please verify your informations');
      return;
    }
    await _apiProvider
        .loginUser(_emailController.text, _passwordController.text)
        .then((value) => {
              Get.snackbar('Login Success', 'logged in as ' + value.name),
              setState(() {
                _isLoading = false;
              }),
              Get.offNamed(vueListClub),
            })
        .onError((error, stackTrace) => {
              setState(() {
                _isLoading = false;
              }),
              Get.snackbar('Login failed', error.toString()),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Already an Account ?',
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
                                          key: const Key('email'),
                                          controller: _emailController,
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
                                            key: const Key('password'),
                                            controller: _passwordController,
                                            decoration: const InputDecoration(
                                                labelText: 'Password'),
                                            obscureText: true,
                                            validator: (value) {
                                              if (value == "" ||
                                                  value == null) {
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
                                    key: const Key('login'),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        signIn();
                                      }
                                    }, //signIn,
                                    child: const Text('Login'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Get.offNamed(registerRoute),
                                    child: const Text(
                                        'No account ? Go to register'),
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
