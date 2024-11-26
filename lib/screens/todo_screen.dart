import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Todo>> futureTodos;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureTodos = apiService.fetchTodos();
  }

  void reloadTodos() {
    setState(() {
      futureTodos = apiService.fetchTodos();
    });
  }

  Future<void> showAddTodoDialog() async {
    _controller.clear();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                await apiService.createTodo(Todo(title: _controller.text));
                reloadTodos();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toso List')),
      body: FutureBuilder<List<Todo>>(
        future: futureTodos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await apiService.deleteTodo(todo.id!);
                      reloadTodos();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
