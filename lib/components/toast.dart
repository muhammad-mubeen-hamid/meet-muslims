import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

OverlaySupportEntry appToast(BuildContext context, String message, double width) {
  return showOverlayNotification(
      (context) => Container(
            width: width,
            height: 50,
            margin: const EdgeInsets.only(top: 20),
            child: Card(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(width: 10),
                      Text(message, style: Theme.of(context).textTheme.bodySmall,),
                    ],
                  ),
                ),
              ),
            ),
          ),
      duration: const Duration(seconds: 4));
}
