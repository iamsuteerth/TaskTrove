import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/common/helpers/db_helper.dart';
import 'package:todo/common/models/task_model.dart';
import 'package:todo/common/utils/constants.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<TaskModel> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();
    state = data.map((e) => TaskModel.fromMap(e)).toList();
  }

  void addItem(TaskModel task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  void updateItem(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DBHelper.updateItem(
        id, title, desc, isCompleted, date, startTime, endTime);
    refresh();
  }

  void deleteTodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void markAsCompleted(
    int id,
    String title,
    String desc,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DBHelper.updateItem(id, title, desc, 1, date, startTime, endTime);
    refresh();
  }

  void markAsNotCompleted(
    int id,
    String title,
    String desc,
    String date,
    String startTime,
    String endTime,
  ) async {
    await DBHelper.updateItem(id, title, desc, 0, date, startTime, endTime);
    refresh();
  }

  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.toString().substring(0, 10);
  }

  String getOvermorrow() {
    DateTime overmorrow = DateTime.now().add(const Duration(days: 2));
    return overmorrow.toString().substring(0, 10);
  }

  List<String> last30Days() {
    DateTime oneMonthAgo = DateTime.now().subtract(const Duration(days: 30));
    List<String> dates = [];
    for (var i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  bool getStatus(TaskModel task) {
    bool? isCompleted;
    isCompleted = (task.isCompleted != 0);
    return isCompleted;
  }
}
