import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () => Get.offAllNamed(Routes.home));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // A direct link to a Task/Checklist illustration
    const String taskImageUrl = 
        'https://cdn-icons-png.flaticon.com/512/906/906334.png'; 

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              scheme.surface,
              scheme.primaryContainer.withOpacity(0.2), // Light fade at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // --- TOP SECTION: Image & Title ---
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Network Image with Animation
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.5, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              // Optional: Add a subtle shadow behind the image
                              boxShadow: [
                                BoxShadow(
                                  color: scheme.primary.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Image.network(
                              taskImageUrl,
                              fit: BoxFit.contain,
                              // Show a spinner while the image downloads
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              // specific error handling if internet fails
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.image_not_supported,
                                size: 80,
                                color: scheme.error,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Task Manager',
style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // --- BOTTOM SECTION: Credits ---
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      'Created by',
                      style: textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sivan Sardar , Mazyar Tariq',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}