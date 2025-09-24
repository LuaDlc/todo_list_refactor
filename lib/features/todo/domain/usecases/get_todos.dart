import 'package:todo_list_refactor/core/usecases/usecases.dart';
import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';

/// caso de uso responsavel por buscar todas as tarefas
/// //depende apenas do repositorio(abstracao)
class GetTodos implements UseCase<List<TodoEntity>, NoParams> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<List<TodoEntity>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
