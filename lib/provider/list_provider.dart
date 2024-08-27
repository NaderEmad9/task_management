import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_management/firebase_utils.dart';
import 'package:task_management/model/task.dart';

class ListProvider with ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();

  Future<void> getAllTasksFromFireStorage(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
    List<Task> allTasks = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList = allTasks.where((task) {
      return task.dateTime.day == selectedDate.day &&
          task.dateTime.month == selectedDate.month &&
          task.dateTime.year == selectedDate.year;
    }).toList();

    tasksList.sort((task1, task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });
    notifyListeners();
  }

  Future<void> changeSelectedDate(DateTime newSelectedDate, String uId) async {
    selectedDate = newSelectedDate;
    await getAllTasksFromFireStorage(uId);
  }
}
