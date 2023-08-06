import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final double height;
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final bool isEnabled;
  final FocusNode focusNode;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const AppTextField({
    Key? key,
    required this.height,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    required this.isEnabled,
    this.errorText,
    this.onTapOutside,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    widget.focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _iconColor = widget.focusNode.hasFocus ? Colors.black : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        enabled: widget.isEnabled,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: Icon(widget.icon, color: _iconColor,),
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(14),
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: Text(
              widget.label,
            ),
          ),
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
          errorText: widget.errorText,
          errorStyle: TextStyle(
              height: 1,
              color: Theme.of(context).errorColor,
              fontWeight: FontWeight.bold),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onTapOutside: widget.onTapOutside,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        onTap: widget.onTap,
        focusNode: widget.focusNode,
      ),
    );
  }
}
