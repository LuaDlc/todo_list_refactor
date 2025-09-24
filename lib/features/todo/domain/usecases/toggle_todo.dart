import 'package:todo_list_refactor/core/usecases/usecases.dart';
import 'package:todo_list_refactor/features/todo/domain/repositories/todo_repository.dart';

///responsavel por marcar/desmarcar uma tarefa
///atua sobre o estado da entidade e repassa ao repositorio
class ToggleTodos implements UseCase<void, String> {
  final TodoRepository repository;

  ToggleTodos(this.repository);
  @override
  Future<void> call(String id) async {
    return repository.toggletodo(id);
  }
}
