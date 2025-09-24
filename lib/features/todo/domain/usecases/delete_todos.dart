import 'package:todo_list_refactor/core/usecases/usecases.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';

///caso de uso responsavel por deletar um,a tarefa especifica
class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;

  DeleteTodo(this.repository);
  @override
  Future<void> call(String id) async {
    return repository.deleteTodo(id);
  }
}

///chama o repositorio para resetar a lista
class ClearTodos implements UseCase<void, NoParams> {
  final TodoRepository repository;

  ClearTodos(this.repository);
  @override
  Future<void> call(NoParams params) {
    return repository.clearTodos();
  }
}
