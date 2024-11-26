class Todo {
  final String? id; 
  final String title;
  final bool completed;

  Todo({this.id, required this.title, this.completed = false});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['_id'], // API's generated ID field
      title: json['title'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
