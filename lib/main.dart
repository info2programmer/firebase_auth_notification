import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_firebase_flutter/controller/auth_service.dart';
import 'package:sample_firebase_flutter/controller/notification_service.dart';
import 'package:sample_firebase_flutter/views/message_screen.dart';
import 'views/firebase_options.dart';
import 'package:sample_firebase_flutter/views/home_screen.dart';
import 'package:sample_firebase_flutter/views/login_sceen.dart';
import 'package:sample_firebase_flutter/views/signup_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some nOtification Recived in background!");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init Firebase messaging
  await PushNotifications.init();

  // Init Local Notification
  await PushNotifications.localNotiInit();

  // Listen Background Notification
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // On background notification taaped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background notification tapped");
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  // To handel forground notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payload = jsonEncode(message.data);
    print("Got a message in Foreground");

    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payload);
    }
  });

  // To handel remote message
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

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
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => const CheckUser(),
        "/login-screen": (context) => const LoginScreen(),
        "/signup-screen": (context) => const SignupScreen(),
        "/home-screen": (context) => const HomeScreen(),
        "/message": (context) => const MessageScreen()
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
