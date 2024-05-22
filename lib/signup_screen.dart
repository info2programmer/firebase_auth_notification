import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_firebase_flutter/components/buttton_tonal.dart';
import 'package:sample_firebase_flutter/controller/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  "Welcome chif, Signup!",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: emailTextController,
                  style: Theme.of(context).textTheme.displaySmall,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    labelText: 'Email Address',
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
                    await AuthService.createAccountWithEmail(
                            emailTextController.text,
                            passwordTextController.text)
                        .then((value) {
                      if (value == "Account created!") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Account Created"),
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home-screen", (route) => true);
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
                    "  Sign Up!  ",
                    style: GoogleFonts.lato(fontSize: 20.0),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/"),
                  child: Text(
                    "Already have account? Login Here!",
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
