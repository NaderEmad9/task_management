import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/auth/login/login_screen.dart';
import 'package:task_management/auth/register/register_screen.dart';
import 'package:task_management/firebase_options.dart';
import 'package:task_management/home/home_screen.dart';
import 'package:task_management/provider/app_theme_provider.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/provider/list_provider.dart';
import 'package:task_management/ui/app_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ListProvider()),
      ChangeNotifierProvider(create: (context) => AuthUserProvider()),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen()
      },
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
