import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/model/task.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/provider/list_provider.dart';
import 'package:task_management/task/task_list_item.dart';
import 'package:task_management/ui/app_colors.dart';

class TaskTab extends StatefulWidget {
  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  List<Task> tasksList = [];

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);

    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStorage(
        authProvider.currentUser!.id!,
      );
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: listProvider.selectedDate,
          onDateChange: (selectedDate) {
            listProvider.changeSelectedDate(
              selectedDate,
              authProvider.currentUser!.id!,
            );
            setState(() {});
          },
          activeColor: AppColors.darkItem,
          headerProps: const EasyHeaderProps(
            // centerHeader: true,
            monthPickerType: MonthPickerType.switcher,
            monthStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            showMonthPicker: true,
            showHeader: true,
            showSelectedDate: false,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: EasyDayProps(
            activeDayStyle: DayStyle(
              splashBorder: BorderRadius.circular(36),
              dayStrStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: AppColors.whiteColor),
              monthStrStyle: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: AppColors.whiteColor),
              dayNumStyle: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppColors.whiteColor),
              decoration: BoxDecoration(
                color: AppColors.lightDate,
                borderRadius: BorderRadius.circular(36),
              ),
            ),
            inactiveDayStyle: DayStyle(
              splashBorder: const BorderRadius.all(Radius.circular(36)),
              dayStrStyle: Theme.of(context).textTheme.displayMedium,
              monthStrStyle: Theme.of(context).textTheme.displayMedium,
              dayNumStyle: Theme.of(context).textTheme.headlineSmall,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            todayStyle: DayStyle(
              splashBorder: const BorderRadius.all(Radius.circular(36)),
              dayStrStyle: Theme.of(context).textTheme.displayMedium,
              monthStrStyle: Theme.of(context).textTheme.displayMedium,
              dayNumStyle: Theme.of(context).textTheme.headlineSmall,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: AppColors.blueColor, width: 2),
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          timeLineProps: const EasyTimeLineProps(
            hPadding: 16.0,
            separatorPadding: 16.0,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) {
              return TaskListItem(
                task: listProvider.tasksList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
