import 'package:logging/logging.dart';

import '../../data/repository/todos/todos_repository.dart';
import '../../utils/result/result.dart';
import '../models/todo.dart';

class TodoUpdateUseCase {
  final TodosRepository _todosRepository;
  final _logger = Logger('TodoUpdateUseCase');

  TodoUpdateUseCase({
    required TodosRepository todosRepository, //
  }) : _todosRepository = todosRepository;

  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _todosRepository.updateTodo(todo);

      switch (result) {
        case Ok<Todo>():
          _logger.fine('Tarefa atualizada com sucesso');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e, s) {
      _logger.warning('Erro ao atualizar tarefa', e, s);
      return Result.error(e);
    }
  }
}
