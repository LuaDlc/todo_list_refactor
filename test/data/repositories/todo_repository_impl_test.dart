import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_list_refactor/features/todo/data/datasources/todolist_local_data_source.dart';
import 'package:todo_list_refactor/features/todo/data/models/todo_model.dart';
import 'package:todo_list_refactor/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
@GenerateMocks([TodolistLocalDataSource])
import 'todo_repository_impl_test.mocks.dart';

void main() {
  late TodoRepositoryImpl repository;
  late MockTodolistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockTodolistLocalDataSource();
    repository = TodoRepositoryImpl(
      todolistLocalDataSource: mockLocalDataSource,
    );
  });

  group('getTodos', () {
    final tTodoModel = TodoModel(id: '1', title: 'test', isDone: false);
    final todoList = [tTodoModel];
    test(
      'should return the data locally when call data source is successfully',
      () async {
        //Arrange
        when(
          mockLocalDataSource.getLastTodoList(),
        ).thenAnswer((_) async => todoList);
        //Act
        final result = await repository.getTodos();

        //Assert
        verify(mockLocalDataSource.getLastTodoList());
        expect(result, isA<List<TodoEntity>>());
        expect(result.first.title, 'test');
      },
    );

    test(
      'should return cachefailure when there is no cached data present',
      () async {
        when(mockLocalDataSource.getLastTodoList()).thenThrow(Exception());

        final result = await repository.getTodos();
        verify(mockLocalDataSource.getLastTodoList());
        expect(result, []);
      },
    );
  });

  group('addTodo', () {
    final tTodo = TodoEntity(id: '1', title: 'test', isDone: false);
    final tTodoModel = TodoModel.fromEntity(tTodo);
    test('should add todo and save in cache', () async {
      when(
        mockLocalDataSource.getLastTodoList(),
      ).thenAnswer((_) async => <TodoModel>[]);
      await repository.addTodo(tTodo);

      verify(mockLocalDataSource.cacheTodoList([tTodoModel])).called(1);
    });
  });

  group('toggleTodo', () {
    test('should toggle todo with concluded and save cache', () async {
      final tTodo = TodoModel(id: '1', title: 'test', isDone: false);
      final updatedTodo = TodoModel(id: '1', title: 'test', isDone: true);

      when(
        mockLocalDataSource.getLastTodoList(),
      ).thenAnswer((_) async => [tTodo]);

      await repository.toggletodo('1');

      verify(mockLocalDataSource.cacheTodoList([updatedTodo])).called(1);
    });
  });

  group('delete todo', () {
    final tTodo = TodoModel(id: '1', title: 'test', isDone: false);
    test('should delete todo and save in cache', () async {
      when(
        mockLocalDataSource.getLastTodoList(),
      ).thenAnswer((_) async => [tTodo]);

      await repository.deleteTodo('1');

      verify(mockLocalDataSource.cacheTodoList([])).called(1);
    });
  });

  group('clear todos', () {
    test('should clear todos and save in cache', () async {
      when(
        mockLocalDataSource.cacheTodoList([]),
      ).thenAnswer((_) async => Future.value());

      await repository.clearTodos();

      verify(mockLocalDataSource.cacheTodoList([])).called(1);
    });
  });
}
