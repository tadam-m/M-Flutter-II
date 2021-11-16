import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class LoginNavigation extends StatefulWidget {
  const LoginNavigation({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.changeLoadingState,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function(bool value) changeLoadingState;

  @override
  State<LoginNavigation> createState() => _LoginNavigationState();
}

class _LoginNavigationState extends State<LoginNavigation> {
  final ApiManager _apiProvider = ApiManager(client: http.Client());

  signIn() async {
    await _apiProvider
        .loginUser(widget.emailController.text, widget.passwordController.text)
        .then((value) => {
              Get.snackbar('Login Success', 'logged in as ' + value.name),
              widget.changeLoadingState(false),
              Get.offNamed(vueListClub),
            })
        .onError((error, stackTrace) => {
              widget.changeLoadingState(false),
              Get.snackbar('Login failed', error.toString()),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () => Get.toNamed(vueListClub),
          child: const Text('Bypass login'),
        ),
        ElevatedButton(
          key: const Key('login'),
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.changeLoadingState(true);
              signIn();
            }
          }, //signIn,
          child: const Text('Login'),
        ),
        ElevatedButton(
          key: const Key('goToRegister'),
          onPressed: () => Get.offNamed(registerRoute),
          child: const Text('No account ? Go to register'),
        ),
      ],
    );
  }
}
