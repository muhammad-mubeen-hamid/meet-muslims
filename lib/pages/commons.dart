import 'package:flutter/material.dart';

import '../components/button.dart';

void signUpBottomModal(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  const title = 'Sign up to continue';
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close the modal
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  AppButton(
                      width: width,
                      height: Theme.of(context).buttonTheme.height,
                      title: 'Use Social Signup Instead',
                      color: Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .secondary,
                      isEnabled: true,
                      isLoading: false,
                      loadingText: 'Loading...',
                      onPressed: () {
                        Navigator.pop(context);
                        signUpSocialBottomModal(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

void signUpSocialBottomModal(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  const title = 'Sign up with your social accounts';
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close the modal
                  signUpBottomModal(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  AppButton(
                      width: width,
                      height: Theme.of(context).buttonTheme.height,
                      leadingAsset: 'lib/assets/icons/google.svg',
                      title: 'Login in with Google',
                      color:
                      Theme.of(context).buttonTheme.colorScheme!.secondary,
                      isEnabled: true,
                      isLoading: false,
                      loadingText: 'Loading...',
                      onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
