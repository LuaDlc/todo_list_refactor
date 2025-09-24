import 'package:todo_list_refactor/features/todo/data/datasources/todolist_local_data_source.dart';
import 'package:todo_list_refactor/features/todo/data/models/todo_model.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';

///implementacao do contrato do repositorio
///conecta os usecases á fonde de dados ([DATA SOURCE])
class TodoRepositoryImpl implements TodoRepository {
  final TodolistLocalDataSource todolistLocalDataSource;

  TodoRepositoryImpl({required this.todolistLocalDataSource});

  @override
  Future<List<TodoEntity>> getTodos() async {
    try {
      final todos = await todolistLocalDataSource.getLastTodoList();
      return todos;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> toggletodo(String id) async {
    final todos = await getTodos();
    final updated = todos.map((todo) {
      if (todo.id == id) {
        return TodoModel(id: todo.id, title: todo.title, isDone: !todo.isDone);
      }
      return TodoModel(id: todo.id, title: todo.title, isDone: todo.isDone);
    }).toList();
    await todolistLocalDataSource.cacheTodoList(updated.cast<TodoModel>());
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todos = await getTodos();
    final updated = List<TodoModel>.from(
      todos.map((e) => TodoModel(id: e.id, title: e.title, isDone: e.isDone)),
    );

    updated.add(TodoModel(id: todo.id, title: todo.title, isDone: todo.isDone));

    await todolistLocalDataSource.cacheTodoList(updated);
  }

  @override
  Future<void> clearTodos() async {
    await todolistLocalDataSource.cacheTodoList([]);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await getTodos();
    final updated = todos
        .where((todo) => todo.id != id)
        .map((e) => TodoModel(id: e.id, title: e.title, isDone: e.isDone))
        .toList();
    await todolistLocalDataSource.cacheTodoList(updated);
  }
}
