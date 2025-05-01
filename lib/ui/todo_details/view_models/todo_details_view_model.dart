import 'package:flutter/material.dart';

import '../../../data/repository/todos/todos_repository.dart';
import '../../../domain/models/todo.dart';
import '../../../domain/use_cases/todo_update_use_case.dart';
import '../../../utils/command/command.dart';
import '../../../utils/result/result.dart';

class TodoDetailsViewModel extends ChangeNotifier {
  final TodosRepository _todosRepository;
  final TodoUpdateUseCase _todoUpdateUseCase;

  TodoDetailsViewModel({
    required TodosRepository todosRepository,
    required TodoUpdateUseCase todoUpdateUseCase,
  }) : _todosRepository = todosRepository,
       _todoUpdateUseCase = todoUpdateUseCase {
    load = Command1(_load);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
    _todosRepository.addListener(() {
      load.execute(_todo.id);
    });
  }

  late final Command1<Todo, String> load;

  late final Command1<Todo, Todo> updateTodo;

  late Todo _todo;

  Todo get todo => _todo;

  Future<Result<Todo>> _load(String id) async {
    try {
      final result = await _todosRepository.getById(id);

      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
          return Result.ok(_todo);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
