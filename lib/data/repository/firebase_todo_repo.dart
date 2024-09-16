import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/models/todo_model.dart';
import '../../domain/repository/todo_repo.dart';

class FirebaseTodoRepo implements TodoRepo {
  final FirebaseFirestore firebaseFirestore;
  final User? user;

  FirebaseTodoRepo({required this.firebaseFirestore})
      : user = FirebaseAuth.instance.currentUser;

  // Get Todos
  @override
  Future<List<TodoModel>> getTodo() async {
    final querySnapshot = await firebaseFirestore
        .collection('todos')
        .doc(user!.uid)
        .collection('userTodos')
        .get();

    return querySnapshot.docs.map((doc) {
      return TodoModel.fromMap(doc.data());
    }).toList();
  }

  // Add Todo
  @override
  Future<void> addTodo(String newTodo) async {
    // Create a TodoModel from the String
    final todoModel = TodoModel(
      id: firebaseFirestore
          .collection('notes')
          .doc()
          .id, // Generate a unique ID
      text: newTodo,
      isCompleted: false, // Default completed status
    );

    // Convert TodoModel to a map and add it to Firebase
    final todoData = todoModel.toMap();
    await firebaseFirestore
        .collection('todos')
        .doc(user!.uid)
        .collection('userTodos')
        .doc(todoModel.id) // Use the generated ID as the document ID
        .set(todoData);
  }

  // Update Todo
  @override
  Future<void> updateTodo(String todoId) async {
    // Fetch the todo from Firebase
    final todoDoc = await firebaseFirestore
        .collection('todos')
        .doc(user!.uid)
        .collection('userTodos')
        .doc(todoId)
        .get();

    if (todoDoc.exists) {
      // Assuming we update the 'completed' status or other fields
      await firebaseFirestore
          .collection('todos')
          .doc(user!.uid)
          .collection('userTodos')
          .doc(todoId)
          .update({
        'completed': true, // Example update: mark the task as completed
      });
    }
  }

  // Delete Todo
  @override
  Future<void> deleteTodo(String todoId) async {
    await firebaseFirestore
        .collection('todos')
        .doc(user!.uid)
        .collection('userTodos')
        .doc(todoId)
        .delete();
  }
}
