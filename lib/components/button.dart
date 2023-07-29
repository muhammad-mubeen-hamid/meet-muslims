import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatefulWidget {
  final double height, width;
  final String title;
  final Color color;
  final bool isLoading;
  final String loadingText;
  final bool isEnabled;
  final String? leadingAsset;
  final Function() onPressed;

  const AppButton({
    Key? key,
    required this.width,
    required this.height,
    required this.title,
    required this.color,
    required this.isLoading,
    required this.loadingText,
    required this.isEnabled,
    this.leadingAsset,
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
          color: widget.color.withAlpha(widget.isEnabled == true ? 255 : 100),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: widget.color, width: 5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Row(
            children: [
              // leading
              Expanded(
                child: widget.leadingAsset == null
                    ? Container(): SvgPicture.asset(
                        widget.leadingAsset ?? '',
                      ),
              ),
              // title
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.isLoading ?
                        Row(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: widget.color.computeLuminance() > 0.4 ? Colors.black : Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.loadingText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall?.copyWith(color: widget.color.computeLuminance() > 0.4 ? Colors.black : Colors.white),
                            )
                          ],
                        ):
                    Text(
                      widget.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall?.copyWith(color: widget.color.computeLuminance() > 0.4 ? Colors.black : Colors.white),
                    )
                  ],
                ),
              ),
              // trailing
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
