import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/todo.dart';

class StorageService {
  static const String _todosKey = 'todos_list';
  final _logger = Logger('StorageService');

  Future<bool> saveTodos(List<Todo> todos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = todos.map((todo) => jsonEncode(todo.toJson())).toList();
      return await prefs.setStringList(_todosKey, jsonList);
    } catch (e, s) {
      _logger.warning('Erro ao salvar tarefas', e, s);
      return false;
    }
  }

  Future<List<Todo>> loadTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_todosKey) ?? [];

      return jsonList
          .map((e) => Todo.fromJson(jsonDecode(e)))
          .toList();
    } catch (e, s) {
      _logger.warning('Erro ao carregar tarefas', e, s);
      return [];
    }
  }

  Future<bool> addTodo(Todo todo) async {
    try {
      final todos = await loadTodos();
      todos.add(todo);
      return await saveTodos(todos);
    } catch (e, s) {
      _logger.warning('Erro ao adicionar tarefa', e, s);
      return false;
    }
  }

  Future<bool> updateTodo(Todo todo) async {
    try {
      final todos = await loadTodos();
      final index = todos.indexWhere((t) => t.id == todo.id);

      if (index != -1) {
        todos[index] = todo;
        return await saveTodos(todos);
      }

      return false;
    } catch (e, s) {
      _logger.warning('Erro ao atualizar tarefa', e, s);
      return false;
    }
  }

  Future<bool> removeTodo(String todoId) async {
    try {
      final todos = await loadTodos();
      todos.removeWhere((todo) => todo.id == todoId);
      return await saveTodos(todos);
    } catch (e, s) {
      _logger.warning('Erro ao remover tarefa', e, s);
      return false;
    }
  }

  Future<bool> clearTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_todosKey);
    } catch (e, s) {
      _logger.warning('Erro ao limpar tarefas', e, s);
      return false;
    }
  }
}
