import 'package:flutter/material.dart';
import 'package:meet_muslims_client/components/button.dart';
import 'package:meet_muslims_client/pages/sign_in.dart';
import 'package:meet_muslims_client/pages/sign_up_step_one.dart';

import 'commons.dart';

class Landing extends StatefulWidget {
  static const routeName = '/landing';
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const height = 50.0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                  width: width,
                  height: height,
                  title: "Sign In",
                  color: Theme.of(context).buttonTheme.colorScheme!.primary,
                  isEnabled: true,
                  isLoading: false,
                  loadingText: "Signing in...",
                  onPressed: () {
                    Navigator.pushNamed(context, SignIn.routeName);
                  }
              ),
              SizedBox(height: 10),
              AppButton(
                  width: width,
                  height: height,
                  isEnabled: true,
                  isLoading: false,
                  loadingText: "Creating account...",
                  title: "Create Account",
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpStepOne.routeName);
                  }
              ),
            ],
          ),
        ),
      )
    );
  }
}
