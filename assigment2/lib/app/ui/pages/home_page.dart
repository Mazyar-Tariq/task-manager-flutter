// Home Page - main page showing list of tasks
import 'package:flutter/material.dart'; // Flutter UI
import 'package:get/get.dart'; // GetX state management

import '../../routes/app_routes.dart'; // Route names
import '../widgets/task_card.dart'; // Task card widget
import '../../controllers/task_controller.dart'; // Task controller
import '../../controllers/theme_controller.dart'; // Theme controller

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>(); // Get task controller
    final categories = ['All', 'Work', 'Study', 'Personal', 'Other']; // Task categories

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'), // App bar title
        actions: [
          // Theme toggle button
          GetBuilder<ThemeController>(
            id: 'theme',
            builder: (themeController) => IconButton(
              icon: Icon(
                themeController.themeMode == ThemeMode.dark
                    ? Icons.light_mode // Light mode icon
                    : Icons.dark_mode, // Dark mode icon
              ),
              onPressed: themeController.toggleTheme, // Toggle theme
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // Padding around body
        child: Column(
          children: [
            // Search field
            TextField(
              onChanged: taskController.setSearch, // Update search query
              decoration: InputDecoration(
                hintText: 'Search tasks...', // Placeholder text
                prefixIcon: const Icon(Icons.search), // Search icon
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16), // Rounded border
                ),
              ),
            ),
            const SizedBox(height: 12), // Space

            // Task counts
            Obx(() {
              final done = taskController.completedCount; // Completed count
              return Wrap(
                spacing: 8, // Space between chips
                runSpacing: 8,
                children: [
                  Chip(label: Text('Total: ${taskController.totalCount}')), // Total tasks
                  Chip(label: Text('Done: $done')), // Completed tasks
                  if (done > 0)
                    ActionChip(
                      label: const Text('Clear completed'), // Clear button
                      onPressed: taskController.clearCompleted, // Clear action
                    ),
                ],
              );
            }),
            const SizedBox(height: 12), // Space

            // Category filter buttons
            SizedBox(
              height: 40, // Fixed height
              child: Obx(() {
                final selectedCat = taskController.selectedCategory.value; // Selected category
                return ListView.separated(
                  scrollDirection: Axis.horizontal, // Horizontal scroll
                  itemBuilder: (_, index) {
                    final category = categories[index]; // Current category
                    final selected = selectedCat == category; // Is selected?
                    return ChoiceChip(
                      label: Text(category), // Category name
                      selected: selected, // Selection state
                      onSelected: (_) => taskController.setCategory(category), // Select action
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8), // Space between chips
                  itemCount: categories.length, // Number of categories
                );
              }),
            ),
            const SizedBox(height: 12), // Space

            // Task list
            Expanded(
              child: Obx(() {
                final category = taskController.selectedCategory.value; // Selected category
                final query = taskController.searchQuery.value.toLowerCase(); // Search query
                final items = taskController.tasks.where((task) {
                  // Filter by category
                  final matchCategory = category == 'All' || task.category == category;
                  // Filter by search query
                  final matchQuery = task.title.toLowerCase().contains(query) ||
                      task.description.toLowerCase().contains(query);
                  return matchCategory && matchQuery; // Both must match
                }).toList();

                if (items.isEmpty) {
                  return const Center(child: Text('No tasks yet')); // Empty state
                }

                return ListView.builder(
                  itemCount: items.length, // Number of tasks
                  itemBuilder: (_, index) {
                    final task = items[index]; // Current task
                    return TaskCard(
                      task: task, // Task data
                      onTap: () => Get.toNamed( // Navigate to details
                        Routes.taskDetails,
                        arguments: task, // Pass task as argument
                      ),
                      onToggle: () => taskController.toggleComplete(task.id), // Toggle completion
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      // Add task button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.addTask), // Navigate to add page
        label: const Text('Add Task'), // Button text
        icon: const Icon(Icons.add), // Add icon
      ),
    );
  }
}
