import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:task_management/firebase_utils.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/provider/list_provider.dart';
import 'package:task_management/task/edit_task.dart';
import 'package:task_management/ui/app_colors.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, listProvider, child) {
        var authProvider = Provider.of<AuthUserProvider>(context);

        return Card(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Slidable(
              startActionPane: task.completed
                  ? null
                  : ActionPane(
                      extentRatio: 0.20,
                      motion: const BehindMotion(),
                      children: [
                        SlidableAction(
                          flex: 1,
                          onPressed: (context) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  EditTaskBottomSheet(task: task),
                            );
                          },
                          backgroundColor: AppColors.blueColor,
                          foregroundColor: AppColors.whiteColor,
                          icon: Icons.edit_outlined,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ],
                    ),
              endActionPane: ActionPane(
                extentRatio: 0.20,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    flex: 1,
                    onPressed: (context) {
                      FirebaseUtils.deleteTaskFromFirestore(
                        task,
                        authProvider.currentUser!.id!,
                      ).then((value) {
                        listProvider.getAllTasksFromFireStorage(
                            authProvider.currentUser!.id!);
                      });
                    },
                    backgroundColor: AppColors.redColor,
                    foregroundColor: AppColors.whiteColor,
                    icon: CupertinoIcons.delete,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12)),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  width: 5,
                  color: task.completed
                      ? AppColors.greenColor
                      : AppColors.blueColor,
                ),
                title: Text(
                  task.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: task.completed
                            ? AppColors.greenColor
                            : AppColors.blueColor,
                      ),
                ),
                subtitle: Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                      ),
                ),
                trailing: IntrinsicWidth(
                  child: Container(
                    decoration: BoxDecoration(
                      color: task.completed
                          ? AppColors.greenColor
                          : AppColors.blueColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: task.completed
                            ? AppColors.greenColor
                            : AppColors.blueColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: task.completed
                          ? Text(
                              'Done!',
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          : const Icon(
                              Icons.check,
                              color: AppColors.whiteColor,
                            ),
                      onPressed: () async {
                        bool newCompletionStatus = !task.completed;
                        Task updatedTask = Task(
                          id: task.id,
                          title: task.title,
                          description: task.description,
                          dateTime: task.dateTime,
                          completed: newCompletionStatus,
                        );
                        await FirebaseUtils.updateTaskInFirestore(
                            updatedTask, authProvider.currentUser!.id!);
                        await listProvider.getAllTasksFromFireStorage(
                            authProvider.currentUser!.id!);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
