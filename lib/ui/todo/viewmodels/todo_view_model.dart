import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

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

  final _logger = Logger('TodoViewModel');

  Future<Result> _load() async {
    try {
      final result = await _todosRepository.get();
      
      switch (result) {
        case Ok<List<Todo>>():
          _todos = result.value;
          _logger.fine('Tarefas carregadas com sucesso');
          break;
        case Error():
          _logger.warning('Falha ao carregar tarefas', result.error);
          break;
      }
      
      return result;
    } on Exception catch (e, s) {
      _logger.severe('Erro ao carregar tarefas', e, s);
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<Todo>> _addTodo((String, String, bool) todo) async {
    try {
      final (name, description, done) = todo;

      final result = await _todosRepository.add(
        name: name,
        description: description,
        done: done,
      );

      switch (result) {
        case Ok<Todo>():
          _todos.add(result.value);
          _logger.fine('Tarefa adicionada com sucesso');
          break;
        case Error():
          _logger.warning('Falha ao adicionar tarefa', result.error);
          break;
      }

      return result;
    } on Exception catch (e, s) {
      _logger.warning('Erro ao adicionar tarefa', e, s);
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _deleteTodo(Todo todo) async {
    try {
      final result = await _todosRepository.delete(todo);

      switch (result) {
        case Ok<void>():
          _todos.remove(todo);
          break;
        case Error():
          _logger.warning('Falha ao deletar tarefa', result.error);
          break;
      }

      return result;
    } on Exception catch (e, s) {
      _logger.warning('Erro ao deletar tarefa', e, s);
      return Result.error(e);
    } finally {
      notifyListeners();
    }
  }
}
