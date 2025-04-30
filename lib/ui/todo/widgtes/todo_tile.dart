import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../../utils/typedefs/todos.dart';
import '../../../domain/models/todo.dart';
import '../viewmodels/todo_view_model.dart';

class TodoTile extends StatelessWidget {
  final Todo todos;
  final TodoViewModel todoViewModel;
  final OnDeleteTodo onDeleteTodo;

  const TodoTile({
    super.key,
    required this.todos,
    required this.todoViewModel,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          Routes.todoDetails(todos.id), //
        );
      },
      child: Card(
        child: ListTile(
          leading: Text(todos.id),
          title: Text(todos.name),
          trailing: IconButton(
            onPressed: () {
              todoViewModel.deleteTodo.execute(todos);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red, //
            ),
          ),
        ),
      ),
    );
  }
}
