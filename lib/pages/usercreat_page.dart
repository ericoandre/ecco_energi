import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // wrong password message popup
  void wrongMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              'Dados Não Confere',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void cadastrar(String email, String senha) async {
    try {
      await _firestore.collection('usuarios').add({
        'email': email,
        'password': senha,
      });
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              SizedBox(
                width: 256,
                height: 256,
                child: Image.asset("assets/images/solar.png"),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(
                              onPressed: () async {
                                if (_passwordController.value ==
                                    _passwordControllerdois.value) {
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text
                                                .trim());

                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    print(e);
                                    wrongMessage();
                                  }
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } else {
                                  wrongMessage();
                                }
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
                                      builder: (context) => const AuthPage()));
                            })
                      ]))
            ])));
  }
}
