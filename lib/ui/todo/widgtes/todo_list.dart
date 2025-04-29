import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';
import 'todo_tile.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList({
    super.key,
    required this.todos, //
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos at moment...'), //
      );
    }
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index]);
      },
    );
  }
}
