import 'package:lista_de_tarefas_tpc/data/services/models/todo/todo_api_model.dart';

void main() {
  const todoApiModel = TodoApiModel.create(name: "Teste");

  print(todoApiModel.toJson());

  const todoCreate = CreateTodoApiModel(name: 'Teste');

  print(todoCreate.toJson());

  const updateTodo = UpdateTodoApiModel(
    id: "Test",
    name: "Teste", //
  );

  print(updateTodo.toJson());
}
