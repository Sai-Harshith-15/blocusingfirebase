import 'package:blocusingfirebase/data/repository/firebase_todo_repo.dart';
import 'package:blocusingfirebase/domain/repository/todo_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'presentation/todo_screen.dart';

Future<void> main(List<String> args) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Create the FirebaseTodoRepo with FirebaseFirestore instance
  final todoRepo =
      FirebaseTodoRepo(firebaseFirestore: FirebaseFirestore.instance);

  runApp(MyApp(todoRepo: todoRepo));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({
    super.key,
    required this.todoRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(
        todoRepo: todoRepo,
      ),
    );
  }
}
