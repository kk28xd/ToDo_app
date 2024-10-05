class Task {
  late int? id;
  final String title;
  final int isDone;

  Task({required this.isDone, required this.title, this.id});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}
