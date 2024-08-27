import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/app_theme_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerColors = Theme.of(context).dividerColor;
    final buttonWidth = MediaQuery.of(context).size.width * 0.40;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark ||
        (themeProvider.themeMode == ThemeMode.system &&
            MediaQuery.of(context).platformBrightness == Brightness.dark);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SizedBox(
            width: width * 0.90,
            height: height * 0.50,
            child: Card(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      "Settings",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 22),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.10,
                      endIndent: MediaQuery.of(context).size.width * 0.10,
                      color: dividerColors,
                      height: 2,
                      thickness: 3,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text('Theme',
                        style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Consumer<AppThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<ThemeMode>(
                            buttonStyleData: ButtonStyleData(
                              elevation: 1,
                              width: buttonWidth,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              iconSize: 24,
                              icon: Container(
                                margin: const EdgeInsets.only(
                                    right: 14.0, left: 14.0),
                                child: Icon(
                                  isDarkMode
                                      ? Icons.brightness_2
                                      : CupertinoIcons.sun_max,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: ThemeMode.system,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "System",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.light,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Light",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: ThemeMode.dark,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Dark",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                              ),
                            ],
                            value: themeProvider.themeMode,
                            onChanged: (value) {
                              if (value != null) {
                                themeProvider.toggleTheme(value);
                              }
                            },
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                          ),
                        );
                      },
                    ),
                    // Divider after the dropdown button
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
