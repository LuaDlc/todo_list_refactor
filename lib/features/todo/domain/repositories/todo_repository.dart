import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';

///ccontrato  do repositorio- descreve operacoes da lista de tarefas
/// é implementado pela camada data, mas nao conhece detalhes dela
abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> toggletodo(String id);
  Future<void> deleteTodo(String id);
  Future<void> clearTodos();
}
