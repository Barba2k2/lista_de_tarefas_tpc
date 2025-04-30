import '../../data/repository/todos/todos_repository.dart';
import '../../utils/result/result.dart';
import '../models/todo.dart';

class TodoUpdateUseCase {
  final TodosRepository _todosRepository;

  TodoUpdateUseCase({
    required TodosRepository todosRepository, //
  }) : _todosRepository = todosRepository;

  Future<Result<Todo>> updateTodo(Todo todo) async {
    try {
      final result = await _todosRepository.updateTodo(todo);

      switch (result) {
        case Ok<Todo>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
