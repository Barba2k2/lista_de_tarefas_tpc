import '../../../core/result/result.dart';
import '../../../domain/models/todo.dart';

abstract class TodosRepository {
  Future<Result<List<Todo>>> get();
  Future<Result<Todo>> add(String name);
  Future<Result<void>> delele(Todo todo);
}
