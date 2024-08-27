import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/auth/login/login_screen.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/provider/list_provider.dart';
import 'package:task_management/settings/settings_tab.dart';

import 'package:task_management/task/add_task.dart';
import 'package:task_management/task/task_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthUserProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1847,
        actions: [
          IconButton(
            onPressed: () {
              listProvider.tasksList = [];
              authProvider.currentUser = null;

              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginScreen(),
                  transitionsBuilder: TransitionsBuilders.fadeIn,
                ),
              );
            },
            icon: Icon(
              FluentIcons.sign_out_24_regular,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${authProvider.currentUser!.name!}'s To Do List",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height * 0.09,
        color: Theme.of(context).bottomAppBarTheme.color,
        notchMargin: 12,
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                tooltip: "List",
                icon: Icon(CupertinoIcons.list_bullet),
                label: 'List',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskBottomSheet();
        },
        child: const Icon(CupertinoIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void addTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const AddTaskBottomSheet());
  }

  List<Widget> tabs = [TaskTab(), const SettingsTab()];
}
