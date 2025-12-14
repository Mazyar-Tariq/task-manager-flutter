// App Pages - defines the pages and their routes
import 'package:get/get.dart'; // GetX for routing

// Import all page widgets
import '../ui/pages/add_task_page.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/splash_page.dart';
import '../ui/pages/task_details_page.dart';
import 'app_routes.dart'; // Route names

class AppPages {
  // List of all app routes and their corresponding pages
  static final routes = <GetPage>[
    GetPage(name: Routes.splash, page: () => const SplashPage()), // Splash screen
    GetPage(
      name: Routes.home,
      page: () => const HomePage(), // Home page
      transition: Transition.fadeIn, // Fade transition
    ),
    GetPage(
      name: Routes.addTask,
      page: () => const AddTaskPage(), // Add task page
      transition: Transition.downToUp, // Slide up transition
    ),
    GetPage(
      name: Routes.taskDetails,
      page: () => const TaskDetailsPage(), // Task details page
      transition: Transition.cupertino, // iOS style transition
    ),
  ];
}

