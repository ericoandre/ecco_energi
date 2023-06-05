import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'auth_page.dart';
import 'login_page.dart';

class UserCreatPage extends StatefulWidget {
  const UserCreatPage({super.key});

  @override
  State<UserCreatPage> createState() => _UserCreatPageState();
}

class _UserCreatPageState extends State<UserCreatPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerdois = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 256,
                    height: 256,
                    child: Image.asset("images/solar.png"),
                  ),

                  // email textfield
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  CustomTextField(
                    controller: _passwordControllerdois,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10.0),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 35),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: CustomButton(
                                  onPressed: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  text: "Criar Cadastro",
                                  backColor: Colors.blue,
                                  textColor: Colors.white,
                                )),
                            const SizedBox(height: 20.0),
                            GestureDetector(
                                child: const Text("Login",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontSize: 15)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AuthPage()));
                                })
                          ]))
                ])));
  }
}
