import 'package:flutter/material.dart';

import '../../../core/typedefs/todos.dart';
import '../../../domain/models/todo.dart';
import '../viewmodels/todo_view_model.dart';
import 'todo_tile.dart';

class TodoList extends StatelessWidget {
  final OnDeleteTodo onDeleteTodo;
  final TodoViewModel todoViewModel;
  final List<Todo> todos;

  const TodoList({
    super.key,
    required this.todos,
    required this.todoViewModel,
    required this.onDeleteTodo,
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
        return TodoTile(
          todos: todos[index],
          todoViewModel: todoViewModel,
          onDeleteTodo: onDeleteTodo,
        );
      },
    );
  }
}
