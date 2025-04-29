import 'package:flutter/material.dart';

import 'data/repository/todos/todos_repository_dev.dart';
import 'ui/todo/viewmodels/todo_view_model.dart';
import 'ui/todo/widgtes/todo_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, //
      ),
      home: TodoScreen(
        todoViewModel: TodoViewModel(
          todosRepository: TodosRepositoryDev(), //
        ),
      ),
    );
  }
}
