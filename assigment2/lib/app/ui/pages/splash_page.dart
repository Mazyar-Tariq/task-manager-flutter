
// Splash Page - shows app logo and navigates to home after 2 seconds
import 'dart:async'; // For Timer
import 'package:flutter/material.dart'; // Flutter UI
import 'package:get/get.dart'; // GetX navigation
import '../../routes/app_routes.dart'; // Route names

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Wait 2 seconds then go to home page
    Timer(const Duration(seconds: 2), () => Get.offAllNamed(Routes.home));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme; // Get color scheme

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            // App icon in a circle
            CircleAvatar(
              radius: 48, // Circle size
              backgroundColor: scheme.primaryContainer, // Background color
              child: Icon(
                Icons.task_alt, // Task icon
                size: 48, // Icon size
                color: scheme.onPrimaryContainer, // Icon color
              ),
            ),
            const SizedBox(height: 16), // Space between elements
            // App title
            Text(
              'Task Manager App',
              style: Theme.of(context).textTheme.headlineMedium, // Title style
            ),
            const SizedBox(height: 8), // Space
            // Tagline
            Text(
              'Organize. Prioritize. Finish.',
              style: Theme.of(context).textTheme.bodyMedium, // Body text style
            ),
          ],
        ),
      ),
    );
  }
}
