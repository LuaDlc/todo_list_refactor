import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_refactor/features/todo/data/datasources/todolist_local_data_source.dart';
import 'package:todo_list_refactor/features/todo/data/models/todo_model.dart';
import 'todolist_local_data_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  late TodolistLocalDataSourceImpl dataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = TodolistLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('cache', () {
    final todo = TodoModel(id: '1', title: 'test', isDone: false);
    final tTodo = json.encode([todo.toJson()]);
    test(
      'should return TodoModel from SharedPreferences when there is  cache',
      () async {
        when(
          mockSharedPreferences.getString(CACHED_TODO_LIST),
        ).thenReturn(tTodo);
        final result = await dataSourceImpl.getLastTodoList();
        verify(mockSharedPreferences.getString(CACHED_TODO_LIST)).called(1);
        expect(result, equals([todo]));
      },
    );

    test('should return empty list  when there is no cache', () async {
      when(mockSharedPreferences.getString(CACHED_TODO_LIST)).thenReturn(null);
      final result = await dataSourceImpl.getLastTodoList();
      verify(mockSharedPreferences.getString(CACHED_TODO_LIST)).called(1);
      expect(result, []);
    });
  });

  group('cacheTodoList', () {
    final todo = TodoModel(id: '1', title: 'test', isDone: false);
    final todos = [todo];
    final tTodoJson = json.encode([todo.toJson()]);

    test('should save list of all todos in SharedPreferences', () async {
      when(
        mockSharedPreferences.setString(CACHED_TODO_LIST, tTodoJson),
      ).thenAnswer((_) async => true);

      await dataSourceImpl.cacheTodoList(todos);

      verify(
        mockSharedPreferences.setString(CACHED_TODO_LIST, tTodoJson),
      ).called(1);
    });
  });
}
