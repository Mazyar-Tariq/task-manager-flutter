// Task Card Widget - displays a single task in a card
import 'package:flutter/material.dart'; // Flutter UI
import 'package:intl/intl.dart'; // Date formatting

import '../../data/models/task_model.dart'; // Task model

class TaskCard extends StatelessWidget {
  final Task task; // The task to display
  final VoidCallback onTap; // Callback when card is tapped
  final VoidCallback onToggle; // Callback when checkbox is toggled

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggle,
  });

  // Get color based on priority
  Color _priorityColor(TaskPriority p, ColorScheme scheme) {
    switch (p) {
      case TaskPriority.low:
        return scheme.primaryContainer; // Light color
      case TaskPriority.medium:
        return Colors.amber.shade600; // Yellow
      case TaskPriority.high:
        return Colors.redAccent; // Red
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme; // Get color scheme

    return Card(
      child: ListTile(
        onTap: onTap, // Tap to view details
        leading: Checkbox(
          value: task.isCompleted, // Checkbox state
          onChanged: (_) => onToggle(), // Toggle completion
        ),
        title: Text(
          task.title, // Task title
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null, // Strike through if completed
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to start
          children: [
            if (task.description.isNotEmpty) // Show description if exists
              Text(
                task.description,
                maxLines: 1, // Limit to one line
                overflow: TextOverflow.ellipsis, // Add ... if too long
              ),
            Wrap(
              spacing: 8, // Space between chips
              runSpacing: 4,
              children: [
                Chip(label: Text(task.category)), // Category chip
                Chip(
                  label: Text(
                    task.priority.name.toUpperCase(), // Priority name
                    style: const TextStyle(color: Colors.black87), // Text color
                  ),
                  backgroundColor: _priorityColor(task.priority, scheme), // Background color
                ),
                if (task.dueDate != null) // Show due date if exists
                  Chip(
                    label: Text(DateFormat.yMMMd().format(task.dueDate!)), // Formatted date
                    avatar: const Icon(Icons.event, size: 16), // Calendar icon
                  ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right), // Arrow icon
      ),
    );
  }
}
