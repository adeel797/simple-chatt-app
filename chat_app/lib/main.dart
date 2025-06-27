import 'package:chat_app/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'auth/auth_gate.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Set the status bar color to transparent for a cleaner UI look
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Initialize Firebase with platform-specific options (e.g., Android)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          ThemeProvider(), // Create an instance of ThemeProvider
      child: ChattApp(),
    ),
  );
}

class ChattApp extends StatelessWidget {
  const ChattApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner in the app
      home:
          const AuthGate(), // Set AuthGate as the home screen to manage auth flow
      theme: Provider.of<ThemeProvider>(
        context,
      ).themeData, // Apply theme from ThemeProvider
    );
  }
}
