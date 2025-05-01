import 'package:flutter/material.dart';

import '../../../utils/result/result.dart';
import '../../../domain/models/todo.dart';
import 'todos_repository.dart';

class TodosRepositoryDev extends ChangeNotifier implements TodosRepository {
  final List<Todo> _todos = [];

  @override
  List<Todo> get todos => _todos;

  @override
  Future<Result<Todo>> add({
    required String name,
    required String description,
    required bool done,
  }) async {
    try {
      final lastTodoIndex = _todos.length;

      final Todo cretaedTodo = Todo(
        id: (lastTodoIndex + 1).toString(),
        name: name,
        description: description,
        done: done,
      );

      return Result.ok(cretaedTodo);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    if (_todos.contains(todo)) {
      _todos.remove(todo);
    }
    return Result.ok(null);
  }

  @override
  Future<Result<List<Todo>>> get() async {
    return Result.ok(_todos);
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    return Result.ok(_todos.firstWhere((todo) => todo.id == id));
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final todoIndex = _todos.indexWhere((t) => t.id == todo.id);

      _todos[todoIndex] = todo;

      return Result.ok(todo);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
