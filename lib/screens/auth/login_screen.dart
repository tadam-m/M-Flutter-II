import 'package:flutter/material.dart';

import 'package:techno_clubs_berlin/components/auth/auth_form/login_form.dart';
import 'package:techno_clubs_berlin/components/auth/auth_navigation/login_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  changeLoadingState(bool loadingState) {
    setState(() {
      _isLoading = loadingState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
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
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: LoginForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey)),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: LoginNavigation(
                          emailController: _emailController,
                          passwordController: _passwordController,
                          formKey: _formKey,
                          changeLoadingState: changeLoadingState)),
                )
              ],
            ),
    );
  }
}
