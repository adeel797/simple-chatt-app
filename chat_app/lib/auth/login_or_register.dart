import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Boolean to track whether to show the login page (true) or register page (false)
  bool showLoginPage = true;

  // Function to toggle between login and register pages
  void togglePages() {
    setState(() {
      // Invert the showLoginPage value to switch screens
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Conditionally render LoginScreen or RegisterScreen based on showLoginPage
    return showLoginPage
        ? LoginScreen(onTap: togglePages) // Show login screen with toggle callback
        : RegisterScreen(onTap: togglePages); // Show register screen with toggle callback
  }
}