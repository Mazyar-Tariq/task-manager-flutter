// This is the main entry point of the Flutter app
import 'package:flutter/material.dart'; // Import Flutter material design
import 'package:get/get.dart'; // Import GetX for state management
import 'package:get_storage/get_storage.dart'; // Import GetStorage for local storage

// Import our app components
import 'app/controllers/task_controller.dart'; // Controller for managing tasks
import 'app/controllers/theme_controller.dart'; // Controller for managing theme
import 'app/routes/app_pages.dart'; // Routes configuration
import 'app/routes/app_routes.dart'; // Route names
import 'app/theme/app_theme.dart'; // App theme settings

// Main function - this runs when the app starts
Future<void> main() async {
  // Ensure Flutter is initialized before doing anything
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage for saving data locally
  await GetStorage.init();

  // Put controllers into GetX dependency injection
  Get.put(ThemeController()); // Theme controller for light/dark mode
  Get.put(TaskController()); // Task controller for managing tasks

  // Run the main app widget
  runApp(const TaskManagerApp());
}

// Main app widget - this is the root of our app
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Return GetMaterialApp with theme settings
    return GetBuilder<ThemeController>(
      id: 'rootTheme', // ID for updating theme
      builder: (ThemeController controller) => GetMaterialApp(
        title: 'Task Manager App', // App title
        debugShowCheckedModeBanner: false, // Hide debug banner
        themeMode: controller.themeMode, // Current theme mode
        theme: AppTheme.light, // Light theme
        darkTheme: AppTheme.dark, // Dark theme
        getPages: AppPages.routes, // App pages/routes
        initialRoute: Routes.splash, // Start with splash screen
      ),
    );
  }
}
