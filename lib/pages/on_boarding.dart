import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/button.dart';
import '../components/text_field.dart';
import '../provider/user_provider.dart';

class OnBoarding extends StatefulWidget {
  static const String routeName = '/on_boarding';

  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  // Regex
  RegExp numbersOnly = RegExp(r'^\d+$');

  // Text Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Focus Nodes
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  // Error Texts
  String? fullNameError, mobileNumberError, passwordError, confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Column(children: [
            // section one
            // section two - sign up
            SizedBox(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Meet Muslims',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    'Find your soulmate',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            // section three - text fields
            SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // full name
                  AppTextField(
                    height: 60.0,
                    label: 'Full Name',
                    hint: 'Full Name...',
                    controller: fullNameController,
                    icon: Icons.face,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _fullNameFocusNode,
                    errorText: fullNameError,
                    onChanged: (value) {
                      if (fullNameError != null &&
                          fullNameController.text.isNotEmpty) {
                        setState(() {
                          fullNameError = null;
                        });
                      }
                    },
                  ),
                  AppTextField(
                    height: 60.0,
                    label: 'Phone Number',
                    hint: 'Phone Number...',
                    controller: mobileNumberController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    focusNode: _mobileFocusNode,
                    errorText: mobileNumberError,
                    onChanged: (value) {
                      if (mobileNumberError != null &&
                          numbersOnly.hasMatch(value)) {
                        setState(() {
                          mobileNumberError = null;
                        });
                      }
                    },
                  ),
                  // password
                  AppTextField(
                    height: 60.0,
                    label: 'Password',
                    hint: 'Password...',
                    controller: passwordController,
                    icon: Icons.password,
                    keyboardType: TextInputType.text,
                    focusNode: _passwordFocusNode,
                    errorText: passwordError,
                    onChanged: (value) {
                      if (passwordError != null &&
                          passwordController.text.isNotEmpty) {
                        setState(() {
                          passwordError = null;
                        });
                      }
                    },
                  ),
                  // confirm password
                  AppTextField(
                    height: 60.0,
                    label: 'Confirm Password',
                    hint: 'Confirm Password...',
                    controller: confirmPasswordController,
                    icon: Icons.password,
                    keyboardType: TextInputType.text,
                    focusNode: _confirmPasswordFocusNode,
                    errorText: confirmPasswordError,
                    onChanged: (value) {
                      if (confirmPasswordError != null &&
                          confirmPasswordController.text.isNotEmpty &&
                          (passwordController.text ==
                              confirmPasswordController.text)) {
                        setState(() {
                          confirmPasswordError = null;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            // section four - button
            AppButton(
                width: width,
                height: 40,
                title: 'Continue',
                color: Theme.of(context).buttonTheme.colorScheme!.primary,
                isEnabled: true,
                isLoading: false,
                loadingText: 'Loading',
                onPressed: () {
                  // bool result = validateEmail(emailController.text);
                  // if (!result) return;
                  // userProvider.setUser('1', emailController.text);
                  // Navigator.pushNamed(context, OnBoarding.routeName);
                },)
          ]),
        )));
  }
}
