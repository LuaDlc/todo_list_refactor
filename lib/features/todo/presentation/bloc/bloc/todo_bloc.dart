import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_refactor/core/usecases/usecases.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/delete_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/toggle_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

/// Controla o fluxo de eventos e estados da UI
/// Conecta os casos de uso à camada de apresentação
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final ToggleTodos toggleTodo;
  final DeleteTodo deleteTodo;
  final ClearTodos clearTodos;
  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.toggleTodo,
    required this.deleteTodo,
    required this.clearTodos,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) async {
      emit(TodoLoading());
      final todos = await getTodos(NoParams());
      emit(TodoLoaded(todos: todos));
    });

    on<AddTodoEvent>((event, emit) async {
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final newTodo = TodoEntity(
          id: DateTime.now().toString(),
          title: event.title,
          isDone: false,
        );
        await addTodo(newTodo);
        final updatedList = List<TodoEntity>.from(currentState.todos)
          ..add(newTodo);
        emit(TodoLoaded(todos: updatedList));
      }
    });

    on<ToggleTodoEvent>((event, emit) async {
      await toggleTodo(event.id);
      final todos = await getTodos(NoParams());
      emit(TodoLoaded(todos: todos));
    });

    on<DeleteTodoEvent>((event, emit) async {
      await deleteTodo(event.id);
      final todos = await getTodos(NoParams());
      emit(TodoLoaded(todos: todos));
    });

    on<ClearTodosEvent>((event, emit) async {
      await clearTodos(NoParams());
      emit(const TodoLoaded(todos: []));
    });
  }
}
