import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

typedef MyValidator = String? Function(String?);

class CustomTextField extends StatefulWidget {
  final String label;
  final MyValidator validator;
  final TextInputType type;
  final TextInputAction action;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.validator,
    required this.controller,
    this.action = TextInputAction.next,
    this.type = TextInputType.text,
    this.focusNode,
    this.nextFocusNode,
    this.onFieldSubmitted,
    this.obscureText = false,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText;
    widget.controller.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        validator: widget.validator,
        focusNode: widget.focusNode,
        keyboardType: widget.type,
        obscureText: _obscureText,
        textInputAction: widget.action,
        controller: widget.controller,
        cursorColor: Theme.of(context).appBarTheme.backgroundColor,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          errorStyle: Theme.of(context).textTheme.displaySmall,
          suffixIcon: widget.controller.text.isNotEmpty && widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? FluentIcons.eye_off_24_regular
                        : FluentIcons.eye_48_regular,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: _toggleVisibility,
                )
              : null,
        ),
        onFieldSubmitted: (value) {
          if (widget.onFieldSubmitted != null) {
            widget.onFieldSubmitted!(value);
          }
          if (widget.nextFocusNode != null) {
            widget.nextFocusNode!.requestFocus();
          } else {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}
