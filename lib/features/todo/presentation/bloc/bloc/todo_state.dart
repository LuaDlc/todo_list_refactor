part of 'todo_bloc.dart';

///define os estados possiveis da tela
///UI reage a esses estados para renderizar corretamente [atraves do state]
@immutable
abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoEntity> todos;
  const TodoLoaded({required this.todos});
  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);
}
