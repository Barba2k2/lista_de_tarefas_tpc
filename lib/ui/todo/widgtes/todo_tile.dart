import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';
import '../../../utils/typedefs/todos.dart';
import '../../../domain/models/todo.dart';
import '../viewmodels/todo_view_model.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final TodoViewModel todoViewModel;
  final OnDeleteTodo onDeleteTodo;

  const TodoTile({
    super.key,
    required this.todo,
    required this.todoViewModel,
    required this.onDeleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          Routes.todoDetails(todo.id), //
        );
      },
      child: Card(
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              todoViewModel.updateTodo.execute(
                todo.copyWith(done: value!), //
              );
            },
          ),
          title: Text(todo.name),
          trailing: IconButton(
            onPressed: () {
              todoViewModel.deleteTodo.execute(todo);
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
