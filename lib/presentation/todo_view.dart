import 'package:blocusingfirebase/domain/models/todo_model.dart';
import 'package:blocusingfirebase/presentation/todo_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  void showDialogBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Notes'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            //cancel

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoCubit.addTodo(
                  textController.text,
                  FirebaseAuth.instance.currentUser!.uid,
                );
                Navigator.pop(context);
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //add the todoCubit
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogBox(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: BlocBuilder<TodoCubit, List<TodoModel>>(builder: (context, todos) {
        return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              //get the individual todo from todo list

              final todo = todos[index];

              return ListTile(
                title: Text(todo.text),

                //check box

                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => todoCubit.toggleCompletion(todo),
                ),
                trailing: IconButton(
                  onPressed: () => todoCubit.deleteTodo(todo),
                  icon: const Icon(
                    Icons.cancel,
                  ),
                ),
              );
            });
      }),
    );
  }
}
