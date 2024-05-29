import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'todo/presentation/pages/auth_page.dart';
import 'todo/presentation/pages/todolistscreen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const TodoListScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
