import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_refactor/features/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:todo_list_refactor/injection_container.dart' as di;

import 'features/todo/presentation/pages/todo_list_page.dart';

//estrutura básica
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.lightGreen),
      home: BlocProvider(
        create: (context) => di.sl<TodoBloc>()..add(LoadTodosEvent()),
        child: TodoListPage(),
      ),
    );
  }
}

//estrutura básica-fim
