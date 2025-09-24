import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_refactor/features/todo/data/models/todo_model.dart';

///define contrato e implementacao do armazenamento local
///usa [SHAREDPREFERENCES] para salvar e recuperar os todos
abstract class TodolistLocalDataSource {
  Future<List<TodoModel>> getLastTodoList();

  Future<void> cacheTodoList(List<TodoModel> todos);
}

const CACHED_TODO_LIST = 'CACHED_TODO_LIST';

class TodolistLocalDataSourceImpl implements TodolistLocalDataSource {
  final SharedPreferences sharedPreferences;

  TodolistLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheTodoList(List<TodoModel> todos) async {
    final jsonList = todos.map((todo) => todo.toJson()).toList();
    await sharedPreferences.setString(CACHED_TODO_LIST, json.encode(jsonList));
  }

  @override
  Future<List<TodoModel>> getLastTodoList() async {
    final jsonString = sharedPreferences.getString(CACHED_TODO_LIST);
    if (jsonString != null) {
      final decoded = json.decode(jsonString) as List;
      // ignore: void_checks
      return decoded.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw [];
    }
  }
}
