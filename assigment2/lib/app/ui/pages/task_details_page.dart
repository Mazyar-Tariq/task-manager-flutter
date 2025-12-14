// Task Details Page - shows full details of a single task
import 'package:flutter/material.dart'; // Flutter UI
import 'package:get/get.dart'; // GetX navigation
import 'package:intl/intl.dart'; // Date formatting

import '../../controllers/task_controller.dart'; // Task controller
import '../../data/models/task_model.dart'; // Task model

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final task = Get.arguments as Task; // Get task from navigation arguments
    final taskController = Get.find<TaskController>(); // Get controller
    final scheme = Theme.of(context).colorScheme; // Get color scheme

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'), // Page title
        actions: [
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete), // Delete icon
            onPressed: () {
              taskController.deleteTask(task.id); // Delete task
              Get.back(); // Go back
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // Padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to start
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between
              children: [
                // Task title
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.headlineSmall, // Title style
                  ),
                ),
                // Completion checkbox
                Checkbox(
                  value: task.isCompleted, // Current state
                  onChanged: (_) => taskController.toggleComplete(task.id), // Toggle action
                ),
              ],
            ),
            const SizedBox(height: 8), // Space

            // Task info chips
            Wrap(
              spacing: 8, // Space between chips
              children: [
                Chip(label: Text('ID: ${task.id}')), // Task ID
                Chip(label: Text(task.category)), // Category
                Chip(
                  label: Text(task.priority.name.toUpperCase()), // Priority
                  backgroundColor: _priorityColor(task.priority, scheme), // Color based on priority
                ),
                if (task.dueDate != null)
                  Chip(label: Text(DateFormat.yMMMd().format(task.dueDate!))), // Due date
              ],
            ),
            const SizedBox(height: 12), // Space

            // Description section
            Text(
              'Description', // Section title
              style: Theme.of(context).textTheme.titleMedium, // Style
            ),
            const SizedBox(height: 4), // Space
            Text(task.description.isEmpty ? 'No description' : task.description), // Description text
          ],
        ),
      ),
    );
  }

  // Helper function to get priority color
  Color _priorityColor(TaskPriority p, ColorScheme scheme) {
    switch (p) {
      case TaskPriority.low:
        return scheme.primaryContainer; // Light color for low
      case TaskPriority.medium:
        return Colors.amber.shade400; // Yellow for medium
      case TaskPriority.high:
        return Colors.redAccent; // Red for high
    }
  }
}

