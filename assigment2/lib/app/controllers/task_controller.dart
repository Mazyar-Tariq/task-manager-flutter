// Task Controller - manages all task operations
import 'package:get/get.dart'; // GetX for reactive state management
import 'package:get_storage/get_storage.dart'; // Local storage

import '../data/models/task_model.dart'; // Task model

class TaskController extends GetxController {
  // Observable list of tasks - reactive, UI updates automatically
  final tasks = <Task>[].obs;

  // Storage box for saving tasks
  final box = GetStorage();
  static const key = 'tasks'; // Key for storing tasks

  // Selected category and search query - reactive
  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved tasks from storage when controller starts
    final stored = box.read<List>(key) ?? [];
    tasks.assignAll(
      stored.map((e) => Task.fromJson(Map<String, dynamic>.from(e))),
    );

    // Save tasks whenever tasks list changes
    ever(tasks, (_) {
      box.write(key, tasks.map((e) => e.toJson()).toList());
    });
  }

  // Add a new task
  void addTask(Task task) {
    tasks.add(task);
  }

  // Update an existing task
  void updateTask(Task updated) {
    final idx = tasks.indexWhere((t) => t.id == updated.id);
    if (idx != -1) {
      tasks[idx] = updated;
    }
  }

  // Delete a task by ID
  void deleteTask(int id) {
    tasks.removeWhere((t) => t.id == id);
  }

  // Remove all completed tasks
  void clearCompleted() {
    tasks.removeWhere((t) => t.isCompleted);
  }

  // Toggle task completion status
  void toggleComplete(int id) {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx != -1) {
      tasks[idx] = tasks[idx].copyWith(isCompleted: !tasks[idx].isCompleted);
    }
  }

  // Set selected category for filtering
  void setCategory(String category) {
    selectedCategory.value = category;
  }

  // Set search query for filtering
  void setSearch(String query) {
    searchQuery.value = query;
  }

  // Get total number of tasks
  int get totalCount => tasks.length;

  // Get number of completed tasks
  int get completedCount => tasks.where((t) => t.isCompleted).length;

  // Count tasks in a specific category
  int countByCategory(String category) {
    if (category == 'All') return totalCount;
    return tasks.where((t) => t.category == category).length;
  }

  // Get counts for all categories
  Map<String, int> get categoryCounts => {
        'All': totalCount,
        'Work': countByCategory('Work'),
        'Study': countByCategory('Study'),
        'Personal': countByCategory('Personal'),
        'Other': countByCategory('Other'),
      };

  // Generate next task ID
  int nextId() => tasks.isEmpty
      ? 1
      : tasks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;
}
