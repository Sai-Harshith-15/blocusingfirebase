import 'package:blocusingfirebase/domain/models/todo_model.dart';
import 'package:blocusingfirebase/domain/repository/todo_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  //reference todoRepo

  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  //Load get todo data

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodo();

    emit(todoList);
  }

  //Add

  Future<void> addTodo(String text, String id) async {
    //create a new todo

    final newTodo = TodoModel(
      id: id,
      text: text,
    );
    await todoRepo.addTodo(newTodo.toString());

    // ..reload

    loadTodos();
  }

  //Delete

  Future<void> deleteTodo(TodoModel todo) async {
    await todoRepo.deleteTodo(todo.toString());

//reload
    loadTodos();
  }

  //Toggle

  Future<void> toggleCompletion(TodoModel todo) async {
    final updateTodo = todo.toggleCompletion();

    //update the todo in the repo with new completion status

    await todoRepo.updateTodo(updateTodo.toString());

    //reload

    loadTodos();
  }
}
