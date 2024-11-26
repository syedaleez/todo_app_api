import 'package:flutter/material.dart';
import 'screens/todo_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',         
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: TodoScreen(),           
    );
  }
}
