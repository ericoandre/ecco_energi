import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/eco.png",
                  height: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Vamos começar",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Não ha um momento melhor do que agora para começar.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // custom button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()
                              // const GoogleSignIn()
                              ));
                      // if (ap.isSignedIn == true) {
                      //   await ap.getDataFromSP().whenComplete(
                      //         () => Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => const HomeScreen(),
                      //           ),
                      //         ),
                      //       );
                      // } else {
                      //   Navigator.pushReplacement(
                      //     context,
                      //     // MaterialPageRoute(
                      //     //   builder: (context) => const RegisterScreen(),
                      //     // ),
                      //   );
                      // }
                    },
                    text: "Iniciar",
                    backColor: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
