import 'package:flutter/material.dart';

import '../../../domain/use_cases/todo_update_use_case.dart';
import '../../../utils/command/command.dart';
import '../../../utils/result/result.dart';
import '../../../data/repository/todos/todos_repository.dart';
import '../../../domain/models/todo.dart';

class TodoViewModel extends ChangeNotifier {
  TodoViewModel({
    required TodosRepository todosRepository, //
    required TodoUpdateUseCase todoUpdateUseCase,
  }) : _todosRepository = todosRepository,
       _todoUpdateUseCase = todoUpdateUseCase {
    load = Command0(_load)..execute();
    addTodo = Command1(_addTodo);
    deleteTodo = Command1(_deleteTodo);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
    _todosRepository.addListener(() {
      _todos = _todosRepository.todos;
      notifyListeners();
    });
  }

  final TodosRepository _todosRepository;

  final TodoUpdateUseCase _todoUpdateUseCase;

  late Command0 load;

  late Command1<Todo, (String, String, bool)> addTodo;

  late Command1<void, Todo> deleteTodo;

  late Command1<Todo, Todo> updateTodo;

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
