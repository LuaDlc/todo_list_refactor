import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_refactor/core/usecases/usecases.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/delete_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/toggle_todo.dart';
@GenerateNiceMocks([MockSpec<TodoRepository>()])
import 'todo_usecases_test.mocks.dart';

void main() {
  late GetTodos getTodos;
  late AddTodo addTodo;
  late ToggleTodos toggleTodos;
  late DeleteTodo deleteTodo;
  late ClearTodos clearTodos;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    getTodos = GetTodos(mockTodoRepository);
    addTodo = AddTodo(mockTodoRepository);
    toggleTodos = ToggleTodos(mockTodoRepository);
    deleteTodo = DeleteTodo(mockTodoRepository);
    clearTodos = ClearTodos(mockTodoRepository);
  });
  final todos = [TodoEntity(id: '1', title: 'teste', isDone: false)];

  group('getTodos', () {
    test('deve chamar o repositorio gettodos', () async {
      when(mockTodoRepository.getTodos()).thenAnswer((_) async => todos);
      final result = await getTodos(NoParams());

      expect(result, todos);
      verify(mockTodoRepository.getTodos()).called(1);
    });
  });
  group('addTodo', () {
    test('should call the repository addTodo', () async {
      final todo = TodoEntity(id: '1', title: 'teste', isDone: false);
      when(mockTodoRepository.addTodo(todo)).thenAnswer((_) async {});
      await addTodo(todo);

      verify(mockTodoRepository.addTodo(todo)).called(1);
    });
  });
  group('toggleTodos', () {
    test('should call repository toggleTodo', () async {
      when(mockTodoRepository.toggletodo('1')).thenAnswer((_) async {});

      await toggleTodos('1');
      verify(mockTodoRepository.toggletodo('1')).called(1);
    });
  });
  group('clearTodos', () {
    test('should call repository clearTodos', () async {
      when(mockTodoRepository.clearTodos()).thenAnswer((_) async {});

      await clearTodos(NoParams());
      verify(mockTodoRepository.clearTodos()).called(1);
    });
  });
  group('deleteTodo', () {
    test('should call repository deleteTodos', () async {
      when(mockTodoRepository.deleteTodo('1')).thenAnswer((_) async {});

      await deleteTodo('1');
      verify(mockTodoRepository.deleteTodo('1')).called(1);
    });
  });
}
