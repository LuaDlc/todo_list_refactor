import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_refactor/features/todo/presentation/bloc/bloc/todo_bloc.dart';

///camada de apresentacao- exibe a lista de tarefas e interage via Bloc
///posteriormente pode ser criado widgets para desacoplar esta page
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de tarefas')),
      //corpo do aplicativo:
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: textEditingController),

            SizedBox(
              height: 400,
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TodoLoaded) {
                    final todos = state.todos;
                    if (todos.isEmpty) {
                      return const Center(child: Text('nenhuma tarefa'));
                    }
                    return ListView.separated(
                      separatorBuilder: (_, _) => Divider(),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];

                        return ListTile(
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: todo.isDone,
                                onChanged: (_) {
                                  context.read<TodoBloc>().add(
                                    ToggleTodoEvent(todo.id),
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                    DeleteTodoEvent(todo.id),
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is TodoError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.lime,
            onPressed: () {
              if (textEditingController.text.isNotEmpty) {
                context.read<TodoBloc>().add(
                  AddTodoEvent(textEditingController.text),
                );
                textEditingController.clear();
              }
            },
            child: Icon(Icons.add),
          ), //floatingActionButton
          FloatingActionButton(
            backgroundColor: Colors.lime,
            onPressed: () {
              context.read<TodoBloc>().add(ClearTodosEvent());
              textEditingController.clear();
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
