import 'package:blocusingfirebase/presentation/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repository/todo_repo.dart';
import 'todo_view.dart';

class TodoScreen extends StatelessWidget {
  final TodoRepo todoRepo;
  const TodoScreen({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TodoCubit(todoRepo);
      },
      child: TodoView(),
    );
  }
}
