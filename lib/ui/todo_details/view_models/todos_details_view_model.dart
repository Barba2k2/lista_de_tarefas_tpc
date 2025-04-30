import 'package:flutter/material.dart';

import '../../../data/repository/todos/todos_repository.dart';
import '../../../domain/models/todo.dart';
import '../../../utils/command/command.dart';
import '../../../utils/result/result.dart';

class TodosDetailsViewModel extends ChangeNotifier {
  final TodosRepository _todosRepository;

  TodosDetailsViewModel({
    required TodosRepository todosRepository, //
  }) : _todosRepository = todosRepository {
    load = Command1(_load);
  }

  late final Command1<Todo, String> load;

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
