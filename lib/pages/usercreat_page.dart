import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
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
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordControllerdois,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: CustomButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        text: "Criar Cadastro",
                        backColor: Colors.blue,
                        textColor: Colors.white,
                      ))
                ])));
  }
}
