import 'package:flutter/material.dart';
import 'package:meet_muslims_client/components/button.dart';
import 'package:meet_muslims_client/components/text_field.dart';
import 'package:meet_muslims_client/pages/on_boarding.dart';
import 'package:meet_muslims_client/pages/sign_up_step_one.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class SignIn extends StatefulWidget {
  static const String routeName = '/sign_in';

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  RegExp regexExp = RegExp(r'^[\w-]+@[\w-]+\.\w+$');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String? emailError;

  @override
  void dispose() {
    emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  bool validateEmail(String value) {
    // match the email with the regex and set the error, if required
    bool isTrue = regexExp.hasMatch(value);
    if (!isTrue) {
      setState(() {
        emailError = 'Please enter a valid email';
      });
      return isTrue;
    }
    // else, remove it if regex is satisfied
    setState(() {
      emailError = null;
    });
    return isTrue;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(),
              ),
              Text(
                'Sign in',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.black.withAlpha(200)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextField(
                    height: 60.0,
                    label: 'Email',
                    hint: 'Email...',
                    controller: emailController,
                    icon: Icons.alternate_email,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    errorText: emailError,
                    onChanged: (value) {
                      if (emailError != null && regexExp.hasMatch(value)) {
                        setState(() {
                          emailError = null;
                        });
                      }
                    },
                    onSubmitted: (value) {
                      _emailFocusNode.unfocus();
                      validateEmail(value);
                    },
                  ),
                  AppTextField(
                    height: 60.0,
                    label: 'Password',
                    hint: 'Password...',
                    controller: passwordController,
                    icon: Icons.password,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _passwordFocusNode,
                    errorText: emailError,
                    onChanged: (value) {
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.unfocus();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // the Continue button
                  AppButton(
                      width: width,
                      height: Theme.of(context).buttonTheme.height,
                      title: 'Continue',
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                      isEnabled: emailError == null,
                      isLoading: false,
                      loadingText: 'Loading...',
                      onPressed: () {
                        bool result = validateEmail(emailController.text);
                        if (!result) return;
                        userProvider.setUser('1', emailController.text);
                        Navigator.pushNamed(context, OnBoarding.routeName);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  // the OR divider
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        thickness: 1,
                        endIndent: 10,
                        indent: 5,
                      )),
                      Text(
                        ' OR ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Expanded(
                          child: Divider(
                        thickness: 1,
                        indent: 10,
                        endIndent: 5,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // the Social button
                  AppButton(
                      width: width,
                      height: Theme.of(context).buttonTheme.height,
                      leadingAsset: 'lib/assets/icons/google.svg',
                      title: 'Login in with Google',
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.secondary,
                      isEnabled: emailError == null,
                      isLoading: false,
                      loadingText: 'Loading...',
                      onPressed: () {}),
                ],
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Would you like to join? ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    GestureDetector(
                      child: Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(SignUpStepOne.routeName);
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
