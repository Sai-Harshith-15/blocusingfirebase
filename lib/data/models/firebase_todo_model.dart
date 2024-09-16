class FirebaseTodoModel {
  final String id;
  final String text;
  final bool isCompleted;

  FirebaseTodoModel({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'isCompleted': isCompleted,
    };
  }

  factory FirebaseTodoModel.fromMap(Map<String, dynamic> json) {
    return FirebaseTodoModel(
      id: json['id'],
      text: json['text'],
      isCompleted: json['isCompleted'],
    );
  }
}
