import 'package:todo_list_refactor/features/todo/domain/entities/todo_entity.dart';

///implementa a entidade TodoEntitu com suporte a [JSON]
///permite a conversao para persistencia e [APIS]
class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    required super.isDone,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'isDone': isDone};
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(id: entity.id, title: entity.title, isDone: entity.isDone);
  }
}
