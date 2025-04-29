import 'package:flutter/material.dart';

import '../../../utils/typedefs/todos.dart';
import '../../../domain/models/todo.dart';
import '../viewmodels/todo_view_model.dart';

class TodoTile extends StatefulWidget {
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
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  

  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${widget.todos.id}'),
      title: Text(widget.todos.name),
      trailing: IconButton(
        onPressed: () {
          widget.todoViewModel.deleteTodo.execute(widget.todos);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red, //
        ),
      ),
    );
  }
}
