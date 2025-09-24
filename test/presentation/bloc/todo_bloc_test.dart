import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/add_todo.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/delete_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/get_todos.dart';
import 'package:todo_list_refactor/features/todo/domain/usecases/toggle_todo.dart';
import 'package:todo_list_refactor/features/todo/presentation/bloc/bloc/todo_bloc.dart';
@GenerateMocks([AddTodo, GetTodos, ToggleTodos, DeleteTodo, ClearTodos])
import 'todo_bloc_test.mocks.dart';

void main() {
  late TodoBloc bloc;
  late MockGetTodos mockGetTodos;
  late MockAddTodo mockAddTodo;
  late MockToggleTodos mockToggleTodos;
  late MockDeleteTodo mockDeleteTodo;
  late MockClearTodos mockClearTodos;

  setUp(() {
    mockAddTodo = MockAddTodo();
    mockGetTodos = MockGetTodos();
    mockToggleTodos = MockToggleTodos();
    mockDeleteTodo = MockDeleteTodo();
    mockClearTodos = MockClearTodos();

    bloc = TodoBloc(
      getTodos: mockGetTodos,
      addTodo: mockAddTodo,
      toggleTodo: mockToggleTodos,
      deleteTodo: mockDeleteTodo,
      clearTodos: mockClearTodos,
    );
  });

  final tTodo = TodoEntity(id: '1', title: 'test', isDone: false);
  final tTodos = [tTodo];

  Future<void> pumpEventQueue({int times = 20}) {
    if (times == 0) return Future.value();
    return Future<void>.delayed(
      Duration.zero,
      () => pumpEventQueue(times: times - 1),
    );
  }

  group('LoadTodosEvent', () {
    test('should emit TodoLoading, TodoLoaded when get todos', () async {
      when(mockGetTodos(any)).thenAnswer((_) async => tTodos);

      expectLater(
        bloc.stream,
        emitsInOrder([
          isA<TodoLoading>(),
          isA<TodoLoaded>().having((s) => s.todos, 'todos', tTodos),
        ]),
      );
      bloc.add(LoadTodosEvent());
    });
  });

  group('AddTodoEvent', () {
    test('should add todo and emit [TodoLoaded]', () async {
      when(mockAddTodo(any)).thenAnswer((_) async => {});

      bloc.emit(TodoLoaded(todos: []));

      bloc.add(AddTodoEvent('test'));

      await untilCalled(mockAddTodo(any));
      verify(mockAddTodo(any)).called(1);
    });
  });

  group('ToggleTodoEvent', () {
    test('deve chamar o usecase de toggle e recarregar a lista', () async {
      when(mockToggleTodos(any)).thenAnswer((_) async => {});
      when(mockGetTodos(any)).thenAnswer((_) async => tTodos);

      expectLater(
        bloc.stream,
        emitsInOrder([
          isA<TodoLoaded>().having((s) => s.todos, 'todos', tTodos),
        ]),
      );
      bloc.add(ToggleTodoEvent('1'));
      await pumpEventQueue();

      // await untilCalled(mockToggleTodos(any));
      verify(mockToggleTodos('1')).called(1);
      verify(mockGetTodos(any)).called(1);
    });
  });

  group('DeleteTodoEvent', () {
    test('deve chamar delete e recarregar lista', () async {
      when(mockDeleteTodo(any)).thenAnswer((_) async => {});
      when(mockGetTodos(any)).thenAnswer((_) async => []);
      bloc.emit(
        TodoLoaded(
          todos: [TodoEntity(id: '1', title: 'test', isDone: false)],
        ),
      );
      bloc.add(DeleteTodoEvent('1'));
      await pumpEventQueue();
      // await untilCalled(mockDeleteTodo(any));
      verify(mockDeleteTodo('1')).called(1);
      verify(mockGetTodos(any)).called(1);
    });
  });

  group('ClearTodosEvent', () {
    test('deve chamar clearTodos e emitir lista vazia', () async {
      when(mockClearTodos(any)).thenAnswer((_) async => {});

      bloc.add(ClearTodosEvent());

      await untilCalled(mockClearTodos(any));
      verify(mockClearTodos(any)).called(1);
    });
  });
}
