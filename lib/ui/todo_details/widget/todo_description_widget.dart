import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';

class TodoDescriptionWidget extends StatelessWidget {
  const TodoDescriptionWidget({
    super.key,
    required this.todo, //
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        todo.description,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ), //
      ), //
    );
  }
}
