import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class RegisterNavigation extends StatefulWidget {
  const RegisterNavigation({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.changeLoadingState,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Function(bool value) changeLoadingState;

  @override
  State<RegisterNavigation> createState() => _RegisterNavigationState();
}

class _RegisterNavigationState extends State<RegisterNavigation> {
  final ApiManager _apiProvider = ApiManager(client: http.Client());

  register() async {
    await _apiProvider
        .registerUser(
            widget.usernameController.text, widget.passwordController.text)
        .then((value) => {
              Get.snackbar('Register Success', 'register in as ' + value.name),
              widget.changeLoadingState(false),
              Get.offNamed(vueListClub),
            })
        .onError((error, stackTrace) => {
              widget.changeLoadingState(false),
              Get.snackbar('Register failed', error.toString()),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          key: const Key('register'),
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              widget.changeLoadingState(true);
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
    );
  }
}
