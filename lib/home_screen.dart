import 'package:flutter/material.dart';
import 'package:sample_firebase_flutter/controller/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome Chif",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: <Widget>[
          IconButton.filledTonal(
            onPressed: () async {
              await AuthService.logout();
              Navigator.pushReplacementNamed(context, "/login-screen");
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
