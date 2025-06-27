import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';

class LoginScreen extends StatelessWidget {
  final void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  // Controller for the email input field
  final TextEditingController emailController = TextEditingController();
  // Controller for the password input field
  final TextEditingController passwordController = TextEditingController();

  // Method to handle user login
  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo icon
            Icon(
              Icons.message_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 60,
            ),

            const SizedBox(height: 20),

            // Welcome message
            Text(
              "Welcome Back!!!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16, // Text size
              ),
            ),

            const SizedBox(height: 20),

            // Email input field
            TextFieldWidget(
              label: 'E-mail',
              controller: emailController,
              preIcon: Icons.email_outlined,
              obscureText: false,
            ),

            const SizedBox(height: 20),

            // Password input field
            TextFieldWidget(
              label: 'Password',
              controller: passwordController,
              preIcon: Icons.password,
              obscureText: true,
            ),

            const SizedBox(height: 20),

            // Login button
            ButtonWidget(
              text: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(height: 20),

            // Row for registration prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}