import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/custom_button.dart';

import 'home_screen/home_page.dart';
import 'usercreat_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  GoogleAuthProvider authProvider = GoogleAuthProvider();

  String? name;
  String? mageUrl;
  User? user;

  // wrong email message popup
  void wrongEmailMessage() {
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

  // wrong password message popup
  void wrongPasswordMessage() {
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

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    User? user;

    // Obtain the auth details from the request
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          wrongEmailMessage();
        } else if (e.code == 'invalid-credential') {
          wrongEmailMessage();
        }
      } catch (e) {
        wrongEmailMessage();
      }
    }
    // Once signed in, return the UserCredential
    return user;
  }

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
              child: Image.asset("assets/images/banner-1-energia-solar.png"),
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
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  });

                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                print("email: " + _emailController.text);
                                print("password: " + _passwordController.text);
                                Navigator.pop(context);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              } on FirebaseAuthException catch (e) {
                                Navigator.pop(context);
                                if (e.code == 'user-not-found') {
                                  wrongEmailMessage();
                                } else if (e.code == 'wrong-password') {
                                  wrongPasswordMessage();
                                } else {
                                  wrongPasswordMessage();
                                }
                              }
                            },
                            text: "Login",
                            backColor: Colors.blue,
                            textColor: Colors.white,
                          )),
                      const SizedBox(height: 10.0),

                      // ou
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Ou',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // google loguin
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: CustomButton(
                          onPressed: () async {
                            User? user = await signInWithGoogle();

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomePage(
                                  user: user,
                                ),
                              ),
                            );
                          },
                          text: "Entre com sua conta google",
                          pngIconPath: 'assets/images/google_icon.png',
                          backColor: Colors.white,
                          textColor: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      GestureDetector(
                          child: const Text("Cadastre-se",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 15)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserCreatPage()));
                          }),
                    ]))
          ],
        ),
      ),
    );
  }
}
