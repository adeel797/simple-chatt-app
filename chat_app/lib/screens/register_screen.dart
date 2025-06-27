import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
import '../widgets/button_widget.dart';
import '../widgets/textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Method to handle user registration
  Future<void> _register() async {
    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      if (mounted) {
        // Show error dialog if passwords do not match
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Password Error"),
            content: Text("Passwords do not match"),
          ),
        );
      }
      return;
    }

    // Set loading state to true
    setState(() => _isLoading = true);
    // Create an instance of AuthService for registration
    final auth = AuthService();

    try {
      await auth.signUpWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (mounted) {
        // Show error dialog for registration failure
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registration Error"),
            content: Text(errorMessage),
          ),
        );
      }
    } finally {
      // Reset loading state when registration is complete
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
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

              // Title for the registration screen
              Text(
                "Create an Account",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Email input field
              TextFieldWidget(
                label: 'Email',
                controller: _emailController,
                preIcon: Icons.email_outlined,
                obscureText: false,
              ),
              const SizedBox(height: 15),

              // Password input field
              TextFieldWidget(
                label: 'Password',
                controller: _passwordController,
                preIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 15),

              // Confirm password input field
              TextFieldWidget(
                label: 'Confirm Password',
                controller: _confirmPasswordController,
                preIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 25),

              ButtonWidget(
                text: 'Register',
                onTap: _isLoading ? null : _register,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  // Login link to toggle to the login screen
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login now",
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
      ),
    );
  }
}