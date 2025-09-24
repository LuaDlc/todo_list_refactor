import 'package:equatable/equatable.dart';

///Entity: camada mais interna da camada de dominio
///contem as regras de negocio com entidades fundamentais- nao depende de nenhuma camada externa
class TodoEntity extends Equatable {
  final String id;
  final String title;
  final bool isDone;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.isDone,
  });

  @override
  List<Object?> get props => [id, title, isDone];
}
