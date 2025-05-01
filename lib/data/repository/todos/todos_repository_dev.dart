import 'package:flutter/material.dart';

import '../../../utils/result/result.dart';
import '../../../domain/models/todo.dart';
import '../../services/storage_service.dart';
import 'todos_repository.dart';

class TodosRepositoryDev extends ChangeNotifier implements TodosRepository {
  final StorageService _storageService;
  List<Todo> _todos = [];

  TodosRepositoryDev({StorageService? storageService})
    : _storageService = storageService ?? StorageService() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    _todos = await _storageService.loadTodos();
    notifyListeners();
  }

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

      final Todo createdTodo = Todo(
        id: (lastTodoIndex + 1).toString(),
        name: name,
        description: description,
        done: done,
      );

      _todos.add(createdTodo);

      await _storageService.saveTodos(_todos);

      return Result.ok(createdTodo);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<void>> delete(Todo todo) async {
    try {
      _todos.removeWhere((t) => t.id == todo.id);

      await _storageService.saveTodos(_todos);

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<List<Todo>>> get() async {
    try {
      _todos = await _storageService.loadTodos();

      return Result.ok(_todos);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  Future<Result<Todo>> getById(String id) async {
    try {
      final todo = _todos.firstWhere(
        (todo) => todo.id == id,
        orElse: () => throw Exception('Todo not found'),
      );
      return Result.ok(todo);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final todoIndex = _todos.indexWhere((t) => t.id == todo.id);

      if (todoIndex == -1) {
        throw Exception('Todo not found');
      }

      _todos[todoIndex] = todo;

      await _storageService.saveTodos(_todos);

      return Result.ok(todo);
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
