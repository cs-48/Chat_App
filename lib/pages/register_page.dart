// ignore_for_file: prefer_const_constructors

import 'package:chat_app_demo/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  //email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();
  FocusNode? focusNode;

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  //register method
  void register(BuildContext context) {
    //get auth servie
    final _auth = AuthService();

    //if password matches confirm passowrd --> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    //if password DON'T match confirm password --> show error message to user
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            //welcome back message
            Text(
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            //email textfield
            MyTextField(
              hintText: "E-mail",
              obsecureText: false,
              controller: _emailController,
              focusNode: focusNode,
            ),

            const SizedBox(
              height: 10,
            ),

            //pw textfield
            MyTextField(
              hintText: "Password",
              obsecureText: true,
              controller: _pwController,
              focusNode:focusNode ,
            ),

            const SizedBox(
              height: 10,
            ),

            //Confirm pw textfield
            MyTextField(
              hintText: "Confirm password",
              obsecureText: true,
              controller: _confirmPwController,
              focusNode: focusNode,
            ),

            const SizedBox(
              height: 25,
            ),

            //login button
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(
              height: 25,
            ),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
