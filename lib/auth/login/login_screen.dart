import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/auth/register/register_screen.dart';
import 'package:task_management/firebase_utils.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/ui/dialog_utils.dart';
import 'package:task_management/home/home_screen.dart';
import 'package:task_management/reuseable/text_form_fields.dart';
import 'package:task_management/ui/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  WidgetStateProperty<Color> splashColorController =
      WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      return AppColors.blueColor.withOpacity(0.2);
    },
  );

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Text(
                'Login',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(vertical: height * 0.12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * 0.1),
                  CustomTextField(
                    label: 'Email',
                    type: TextInputType.emailAddress,
                    action: TextInputAction.next,
                    focusNode: _emailFocusNode,
                    nextFocusNode: _passwordFocusNode,
                    controller: _emailController,
                    validator: (text) {
                      if (text!.trim().isEmpty) {
                        return 'Please enter correct Email address.';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: true,
                    label: 'Password',
                    action: TextInputAction.go,
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    validator: (text) {
                      if (text!.trim().length < 8 || text.trim().isEmpty) {
                        return 'Password must be at least 8 characters.';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (text) {
                      if (formKey.currentState?.validate() == true) {
                        login();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        login();
                      }
                    },
                    child: Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const RegisterScreen(),
                          transitionsBuilder: TransitionsBuilders.fadeIn,
                        ),
                      );
                    },
                    splashColor: Colors.transparent,
                    overlayColor: splashColorController,
                    child: Text(
                      "Don't have an account? sign up now!",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppColors.blueColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoadingDialog(
          context: context, message: 'Please wait...');
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        var myUser = await FirebaseUtils.readUserFromFirestore(
            (credential.user?.uid ?? ''));
        if (myUser == null) {
          return;
        }
        var authprovider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authprovider.setCurrentUser(myUser);

        DialogUtils.hideLoadingDialog(context);

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder: TransitionsBuilders.fadeIn,
          ),
        );
      } catch (e) {
        DialogUtils.hideLoadingDialog(context);
        DialogUtils.showAlertDialog(
          context: context,
          title: 'Invalid Account',
          message: 'The email address or password you entered is incorrect.',
          negActionTitle: 'Cancel',
          posActionTitle: 'Sign Up',
          posAction: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const RegisterScreen(),
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
            );
          },
        );
      }
    }
  }
}
