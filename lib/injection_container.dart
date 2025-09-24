import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_refactor/features/todo/data/datasources/todolist_local_data_source.dart';
import 'package:todo_list_refactor/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/delete_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/toggle_todo.dart';
import 'package:todo_list_refactor/features/todo/presentation/bloc/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => TodoBloc(
      getTodos: sl(),
      addTodo: sl(),
      toggleTodo: sl(),
      deleteTodo: sl(),
      clearTodos: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => ToggleTodos(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => ClearTodos(sl()));

  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(todolistLocalDataSource: sl()),
  );

  sl.registerLazySingleton<TodolistLocalDataSource>(
    () => TodolistLocalDataSourceImpl(sharedPreferences: sl()),
  );

  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
}
