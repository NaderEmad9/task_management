import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/firebase_utils.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/provider/list_provider.dart';
import 'package:task_management/ui/app_colors.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final Task task;

  const EditTaskBottomSheet({super.key, required this.task});

  @override
  _EditTaskBottomSheetState createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textFieldStyle =
        Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text('Edit Task',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "Enter Task Name",
                          ),
                          cursorColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          style: textFieldStyle,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Task Name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: "Task Description",
                          ),
                          cursorColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          maxLines: null,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 16),
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Task Description is required';
                            }
                            return null;
                          },
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
                            DateFormat('dd/MM/yyyy')
                                .format(widget.task.dateTime),
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
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              var authProvider = Provider.of<AuthUserProvider>(
                                  context,
                                  listen: false);
                              var listProvider = Provider.of<ListProvider>(
                                  context,
                                  listen: false);

                              Task updatedTask = Task(
                                id: widget.task.id,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                dateTime: widget.task.dateTime,
                                completed: widget.task.completed,
                              );

                              FirebaseUtils.updateTaskInFirestore(updatedTask,
                                      authProvider.currentUser!.id!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        const Text("Task updated successfully"),
                                    showCloseIcon: true,
                                    dismissDirection:
                                        DismissDirection.endToStart,
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: AppColors.blueColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                );
                                listProvider.getAllTasksFromFireStorage(
                                    authProvider.currentUser!.id!);
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(
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

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: widget.task.dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (chosenDate != null) {
      setState(() {
        widget.task.dateTime = chosenDate;
      });
    }
  }
}
