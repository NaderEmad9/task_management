import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/firebase_utils.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/provider/list_provider.dart';
import 'package:task_management/ui/app_colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  static const routeName = "Task";

  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => AddTaskBottomSheetState();
}

class AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formkey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = "";
  String description = "";
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text('Add new Task',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          onChanged: (text) {
                            title = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Task Name is required';
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          cursorColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          decoration: const InputDecoration(
                            hintText: "Enter Task Name",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          onChanged: (text) {
                            description = text;
                          },
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Task Description is required';
                            }
                            return null;
                          },
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 16),
                          cursorColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          decoration: const InputDecoration(
                            hintText: "Task Description",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          "Select Date:",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () {
                            showCalendar();
                          },
                          child: Text(
                            textAlign: TextAlign.center,
                            DateFormat('dd/MM/yyyy').format(selectedDate),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.08),
                        child: IconButton(
                          onPressed: () {
                            addTask();
                          },
                          icon: const Icon(
                            CupertinoIcons.check_mark_circled_solid,
                            size: 64,
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    if (formkey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      FirebaseUtils.addTaskToFireStorage(task, authProvider.currentUser!.id!)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Task added successfully"),
            showCloseIcon: true,
            dismissDirection: DismissDirection.endToStart,
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.blueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
        listProvider.getAllTasksFromFireStorage(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
