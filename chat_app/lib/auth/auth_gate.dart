import 'package:chat_app/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use StreamBuilder to listen for changes in the user's authentication state
      body: StreamBuilder<User?>(
        // Stream that emits updates when the user's auth state changes (e.g., login/logout)
        stream: FirebaseAuth.instance.authStateChanges(),
        // Builder function to handle different states of the stream
        builder: (context, snapshot) {
          // Show a loading indicator while waiting for the auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If the snapshot has data (user is authenticated), show the home screen
          if (snapshot.hasData) {
            return HomeScreen();
          }

          // If no user is authenticated, show the login or register screen
          return const LoginOrRegister();
        },
      ),
    );
  }
}