import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/features/data/cubits/todo_cubit/task_states.dart';
import 'package:todo_app/features/data/models/task_model.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitial()) {
    _init();
  }

  Future<void> _init() async {
    await createDB();
    await getAllTasks(); // Optionally, load tasks right after the database is created
  }

  late Database database;
  String dbName = 'Tasks';
  List<Task>? tasks;

  Future<void> createDB() async {
    try {
      database = await openDatabase('todo.db', version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $dbName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isDone INTEGER)');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> insertTask({required Task task}) async {
    emit(AddTaskLoading());
    try {
      await database.rawInsert(
          "INSERT INTO $dbName(title, isDone) VALUES('${task.title}', ${task.isDone})");
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateTask({required Task task}) async {
    emit(UpdateTaskLoading());
    try {
      int num = task.isDone;
      log(num.toString());
      await database.rawUpdate(
          'UPDATE $dbName SET title = ?, isDone = ? WHERE id = ?',
          [task.title, num, task.id]);
      emit(UpdateTaskSuccess());

    } catch (e) {
      log(e.toString());
      emit(UpdateTaskFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteTask({required Task task}) async {
    try {
      await database.rawDelete('delete from $dbName where id=?', [task.id]);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getAllTasks() async {
    emit(TaskLoading());
    try {
      List<Map<String, dynamic>> results =
          await database.rawQuery('SELECT * FROM $dbName');
      tasks = results.map((taskMap) => Task.fromMap(taskMap)).toList();
      emit(TaskSuccess());
    } catch (e) {
      log(e.toString());
      emit(TaskFailure(errorMessage: e.toString()));
    }
  }
}
