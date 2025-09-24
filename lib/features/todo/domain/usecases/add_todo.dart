import 'package:equatable/equatable.dart';
import 'package:todo_list_refactor/core/usecases/usecases.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';

///define as interacoes e fluxos, depende das entidades mas nao conhece as camadas externas
///invoca a logica de persistencia via repositorio
class AddTodo implements UseCase<void, TodoEntity> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<void> call(TodoEntity todo) async {
    return repository.addTodo(todo);
  }
}

class Params extends Equatable {
  @override
  List<Object?> get props => [];
}
