import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_firebase_flutter/controller/auth_service.dart';
import 'firebase_options.dart';
import 'package:sample_firebase_flutter/home_screen.dart';
import 'package:sample_firebase_flutter/login_sceen.dart';
import 'package:sample_firebase_flutter/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrangeAccent,
          primary: Colors.deepOrange,
          secondary: Colors.deepPurpleAccent,
          background: Colors.white,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.lato(
            fontSize: 30,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.lato(
            fontSize: 20,
            fontStyle: FontStyle.normal,
          ),
          displaySmall: GoogleFonts.lato(
            fontSize: 15,
            fontStyle: FontStyle.normal,
          ),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const CheckUser(),
        "/login-screen": (context) => const LoginScreen(),
        "/signup-screen": (context) => const SignupScreen(),
        "/home-screen": (context) => const HomeScreen()
      },
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    // TODO: implement initState
    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      } else {
        Navigator.pushReplacementNamed(context, '/login-screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
