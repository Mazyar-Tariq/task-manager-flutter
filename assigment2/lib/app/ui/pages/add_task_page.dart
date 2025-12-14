// Add Task Page - form to create a new task
import 'package:flutter/material.dart'; // Flutter UI
import 'package:get/get.dart'; // GetX navigation
import 'package:intl/intl.dart'; // Date formatting

import '../../controllers/task_controller.dart'; // Task controller
import '../../data/models/task_model.dart'; // Task model

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>(); // Form validation key
  final _titleController = TextEditingController(); // Title input
  final _descriptionController = TextEditingController(); // Description input
  String _category = 'Work'; // Selected category
  TaskPriority _priority = TaskPriority.medium; // Selected priority
  DateTime? _dueDate; // Selected due date

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>(); // Get controller
    // Format due date for display
    final dateText = _dueDate == null ? 'Optional' : DateFormat.yMMMd().format(_dueDate!);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')), // Page title
      body: Padding(
        padding: const EdgeInsets.all(16), // Padding
        child: Form(
          key: _formKey, // Form key for validation
          child: ListView(
            children: [
              // Title input field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *', // Required field
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null, // Validation
              ),
              const SizedBox(height: 12), // Space

              // Description input field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description', // Optional
                  border: OutlineInputBorder(),
                ),
                maxLines: 3, // Multiple lines
              ),
              const SizedBox(height: 12), // Space

              // Category dropdown
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Work', child: Text('Work')),
                  DropdownMenuItem(value: 'Study', child: Text('Study')),
                  DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (val) => setState(() => _category = val ?? 'Work'), // Update category
              ),
              const SizedBox(height: 12), // Space

              // Priority dropdown
              DropdownButtonFormField<TaskPriority>(
                initialValue: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: TaskPriority.values
                    .map(
                      (p) => DropdownMenuItem(
                        value: p,
                        child: Text(p.name.toUpperCase()), // Display priority name
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _priority = val ?? TaskPriority.medium), // Update priority
              ),
              const SizedBox(height: 12), // Space

              // Due date picker
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Due Date'), // Label
                subtitle: Text(dateText), // Display selected date
                trailing: IconButton(
                  icon: const Icon(Icons.event), // Calendar icon
                  onPressed: () async {
                    final now = DateTime.now(); // Current date
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? now, // Initial date
                      firstDate: now.subtract(const Duration(days: 0)), // Min date (today)
                      lastDate: now.add(const Duration(days: 365)), // Max date (1 year)
                    );
                    if (picked != null) setState(() => _dueDate = picked); // Update date
                  },
                ),
              ),
              const SizedBox(height: 16), // Space

              // Save button
              ElevatedButton.icon(
                icon: const Icon(Icons.save), // Save icon
                label: const Text('Save Task'), // Button text
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return; // Validate form
                  final id = taskController.nextId(); // Get next ID
                  taskController.addTask( // Add task to controller
                    Task(
                      id: id,
                      title: _titleController.text.trim(), // Trim whitespace
                      description: _descriptionController.text.trim(),
                      category: _category,
                      priority: _priority,
                      dueDate: _dueDate,
                      isCompleted: false, // New tasks are not completed
                    ),
                  );
                  Get.back(); // Go back to previous page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

