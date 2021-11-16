import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:techno_clubs_berlin/components/auth/auth_form/register_form.dart';
import 'package:techno_clubs_berlin/components/auth/auth_navigation/register_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
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
                        emailController: _emailController,
                        passwordController: _passwordController,
                        usernameController: _usernameController,
                        formKey: _formKey,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      child: RegisterNavigation(
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          emailController: _emailController,
                          formKey: _formKey,
                          changeLoadingState: changeLoadingState)),
                ),
              ],
            ),
    );
  }
}
