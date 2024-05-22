import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_firebase_flutter/components/buttton_tonal.dart';
import 'package:sample_firebase_flutter/controller/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome chif!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: emailTextController,
                  style: Theme.of(context).textTheme.displaySmall,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    labelText: 'User Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: passwordTextController,
                  obscureText: true,
                  style: Theme.of(context).textTheme.displaySmall,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    labelText: 'User Password',
                    hintText: 'Enter Your Password',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                FilledButton.tonal(
                  onPressed: () async {
                    await AuthService.loginAccountWithEmail(
                            emailTextController.text,
                            passwordTextController.text)
                        .then((value) {
                      if (value == "Login Successfully!") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Login Successfully!"),
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home-screen", (route) => false);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              value,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    });
                  },
                  child: Text(
                    "  Sign In!  ",
                    style: GoogleFonts.lato(fontSize: 20.0),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/signup-screen"),
                  child: Text(
                    "Do not have account?",
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      color: Theme.of(context).colorScheme.secondary,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
