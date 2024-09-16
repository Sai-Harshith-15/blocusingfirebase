// what app can do

import '../models/todo_model.dart';

abstract class TodoRepo {
  //get todo

  Future<List<TodoModel>> getTodo();

  //add todo

  Future<void> addTodo(String newTodo);

  //update todo

  Future<void> updateTodo(String todo);

  //delete todo

  Future<void> deleteTodo(String todo);
}
