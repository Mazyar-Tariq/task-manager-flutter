// Task Priority enum - defines priority levels
enum TaskPriority { low, medium, high }

// Task class - represents a single task
class Task {
  final int id; // Unique identifier for the task
  final String title; // Task title
  final String description; // Task description
  final String category; // Task category (Work, Study, etc.)
  final TaskPriority priority; // Task priority level
  final DateTime? dueDate; // Optional due date
  final bool isCompleted; // Whether task is completed

  // Constructor - creates a new Task
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.dueDate,
    required this.isCompleted,
  });

  // Copy with method - creates a copy with some fields changed
  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    TaskPriority? priority,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Factory constructor - creates Task from JSON data
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? 'Other',
        priority: TaskPriority.values.firstWhere(
          (p) => p.name == (json['priority'] as String? ?? 'low'),
          orElse: () => TaskPriority.low,
        ),
        dueDate: json['dueDate'] == null
            ? null
            : DateTime.tryParse(json['dueDate'] as String),
        isCompleted: json['isCompleted'] as bool? ?? false,
      );

  // Convert Task to JSON for storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'priority': priority.name,
        'dueDate': dueDate?.toIso8601String(),
        'isCompleted': isCompleted,
      };
}

