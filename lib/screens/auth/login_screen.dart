import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:techno_clubs_berlin/API/api_manager.dart';

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
    await ApiManager()
        .loginUser(_emailController.text, _passwordController.text)
        .then((value) => {
              Get.snackbar('Login Success', 'logged in as ' + value.name),
              setState(() {
                _isLoading = false;
              }),
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
                                    onPressed: () => Get.toNamed(vueListClub),
                                    child: const Text('Bypass login'),
                                  ),
                                  ElevatedButton(
                                    onPressed: signIn,
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
