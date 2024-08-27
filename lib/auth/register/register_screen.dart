import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/auth/login/login_screen.dart';
import 'package:task_management/firebase_utils.dart';

import 'package:task_management/model/my_user.dart';
import 'package:task_management/provider/auth_user_provider.dart';
import 'package:task_management/ui/dialog_utils.dart';
import 'package:task_management/home/home_screen.dart';
import 'package:task_management/reuseable/text_form_fields.dart';
import 'package:task_management/ui/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();
  var confirmPassword;

  WidgetStateProperty<Color> splashColorController =
      WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      return AppColors.blueColor.withOpacity(0.2);
    },
  );

  @override
  void dispose() {
    _userFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'Register',
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
                      label: "User Name",
                      focusNode: _userFocusNode,
                      nextFocusNode: _emailFocusNode,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'Please enter user name.';
                        }
                        return null;
                      },
                      controller: _usernameController),
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
                        return 'Please enter a valid email or username';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: true,
                    label: 'Password',
                    action: TextInputAction.next,
                    focusNode: _passwordFocusNode,
                    nextFocusNode: _confirmPasswordFocusNode,
                    controller: _passwordController,
                    validator: (text) {
                      confirmPassword = text;
                      if (text!.trim().length < 8 || text.trim().isEmpty) {
                        return 'Password must be at least 8 characters.';
                      } else if (text.contains(' ')) {
                        return 'Password cannot contain spaces.';
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomTextField(
                    obscureText: true,
                    label: 'Confirm Password',
                    action: TextInputAction.go,
                    focusNode: _confirmPasswordFocusNode,
                    controller: _confirmPasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please confirm your password.';
                      } else if (confirmPassword != text.trim()) {
                        return 'Passwords do not match.';
                      } else if (text.contains(' ')) {
                        return 'Password cannot contain spaces.';
                      }

                      return null;
                    },
                    onFieldSubmitted: (text) {
                      if (formKey.currentState?.validate() == true) {
                        register();
                      }
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        register();
                      }
                    },
                    child: Text(
                      'Sign Up',
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
                                  const LoginScreen(),
                          transitionsBuilder: TransitionsBuilders.fadeIn,
                        ),
                      );
                    },
                    splashColor: Colors.transparent,
                    overlayColor: splashColorController,
                    child: Text(
                      "Already have an account?",
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoadingDialog(
            context: context, message: 'Creating account...');

        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: _usernameController.text,
            email: _emailController.text);
        var authprovider =
            Provider.of<AuthUserProvider>(context, listen: false);
        authprovider.setCurrentUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);

        Future.delayed(const Duration(milliseconds: 300), () {
          DialogUtils.hideLoadingDialog(context);

          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const HomeScreen(),
              transitionsBuilder: TransitionsBuilders.fadeIn,
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoadingDialog(context);

        if (e.code == 'email-already-in-use') {
          DialogUtils.showAlertDialog(
            context: context,
            title: 'Email already in use',
            message: 'The account already exists for that email.',
            negActionTitle: 'Cancel',
            posActionTitle: 'Sign In',
            posAction: () {
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LoginScreen(),
                  transitionsBuilder: TransitionsBuilders.fadeIn,
                ),
              );
            },
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        DialogUtils.hideLoadingDialog(context);

        DialogUtils.showAlertDialog(
          context: context,
          title: 'Something went wrong',
          message:
              'The email address you entered is incorrect or already exists.',
          negActionTitle: 'Cancel',
          posActionTitle: 'Sign In',
          posAction: () {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const LoginScreen(),
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
            );
          },
        );
      }
    }
  }
}
