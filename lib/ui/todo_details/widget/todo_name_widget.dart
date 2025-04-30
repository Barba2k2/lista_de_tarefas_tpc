import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';

class TodoNameWidget extends StatelessWidget {
  const TodoNameWidget({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8), //
        ),
        color: Colors.blue,
      ),
      child: Text(
        todo.name,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24, //
        ),
      ),
    );
  }
}
