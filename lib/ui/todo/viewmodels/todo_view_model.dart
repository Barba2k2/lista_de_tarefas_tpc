import 'package:flutter/material.dart';

import '../../../utils/command/command.dart';
import '../../../utils/result/result.dart';
import '../../../data/repository/todos/todos_repository.dart';
import '../../../domain/models/todo.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel({
    required TodosRepository todosRepository, //
  }) : _todosRepository = todosRepository {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
  }

  final TodosRepository _todosRepository;

  late Command0 load;

  late Command1<Todo, (String, String, bool)> addTodo;

  late Command1<void, Todo> deleteTodo;

  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<Result> _load() async {
    final result = await _todosRepository.get();

    switch (result) {
      case Ok<List<Todo>>():
        _todos = result.value;
        notifyListeners();
        break;
      case Error():
        // TODO: implement logging
        break;
    }

    return result;
  }

  Future<Result<Todo>> _addTodo((String, String, bool) todo) async {
    final (name, description, done) = todo;

    final result = await _todosRepository.add(
      name: name,
      description: description,
      done: done,
    );

    switch (result) {
      case Ok<Todo>():
        _todos.add(result.value);
        notifyListeners();
        break;
      case Error():
        // TODO: implement logging
        break;
    }

    return result;
  }

  Future<Result<void>> _deleteTodo(Todo todo) async {
    final result = await _todosRepository.delete(todo);

    switch (result) {
      case Ok<void>():
        _todos.remove(todo);
        notifyListeners();
        break;
      case Error():
        // TODO: implement logging
        break;
    }

    return result;
  }
}
