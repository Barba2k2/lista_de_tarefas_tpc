import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repository/todos/todos_repository.dart';
import '../../../domain/models/todo.dart';
import '../../../domain/use_cases/todo_update_use_case.dart';
import '../../../utils/command/command.dart';
import '../../../utils/result/result.dart';

class TodoDetailsViewModel extends ChangeNotifier {
  final TodosRepository _todosRepository;
  final TodoUpdateUseCase _todoUpdateUseCase;
  final _logger = Logger('TodoDetailsViewModel');

  Todo _todo = Todo(
    id: '',
    name: '',
    description: '',
    done: false, //
  );

  bool _isLoaded = false;

  TodoDetailsViewModel({
    required TodosRepository todosRepository,
    required TodoUpdateUseCase todoUpdateUseCase,
  }) : _todosRepository = todosRepository,
       _todoUpdateUseCase = todoUpdateUseCase {
    load = Command1(_load);
    updateTodo = Command1(_todoUpdateUseCase.updateTodo);
    _todosRepository.addListener(_onRepositoryChanged);
  }

  void _onRepositoryChanged() {
    if (_isLoaded) {
      load.execute(_todo.id);
    }
  }

  late final Command1<Todo, String> load;
  late final Command1<Todo, Todo> updateTodo;

  bool get isLoaded => _isLoaded;

  Todo get todo => _todo;

  Future<Result<Todo>> _load(String id) async {
    try {
      if (id.isEmpty) {
        _logger.warning('Tentativa de carregar tarefa com ID vazio');
        return Result.error(Exception('ID de tarefa vazio'));
      }

      final result = await _todosRepository.getById(id);

      switch (result) {
        case Ok<Todo>():
          _todo = result.value;
          _isLoaded = true;
          _logger.fine('Tarefa carregada com sucesso: ${_todo.id}');
          return Result.ok(_todo);
        default:
          _logger.warning('Falha ao carregar tarefa', result.asError.error);
          return result;
      }
    } on Exception catch (e, s) {
      _logger.severe('Erro ao carregar tarefa', e, s);
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _todosRepository.removeListener(_onRepositoryChanged);
    super.dispose();
  }
}
