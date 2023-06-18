import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  const AppTextField({Key? key, required this.label, required this.controller, required this.icon}) : super(key: key);
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        // ICON
        icon: Icon(widget.icon, size: 20),
        // HINT
        hintText: widget.label,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
        ),
        // ERROR
        errorText: widget.controller.text.isEmpty ? 'Please enter your email' : null,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          height: 1,
          color: Theme.of(context).errorColor,
        ),
      ),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        decorationThickness: 0,
      ),
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
