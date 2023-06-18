import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final double height, width;
  final String title;
  final Color? color;
  final Function() onPressed;
  const AppButton({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).buttonTheme.colorScheme?.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(widget.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
