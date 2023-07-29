import 'package:flutter/material.dart';
import 'package:meet_muslims_client/components/button.dart';
import 'package:meet_muslims_client/components/text_field.dart';
import 'package:meet_muslims_client/pages/on_boarding.dart';
import 'package:meet_muslims_client/pages/sign_in.dart';
import 'package:meet_muslims_client/pages/sign_up_step_two.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class SignUpStepOne extends StatefulWidget {
  static const String routeName = '/sign_up_step_one';

  const SignUpStepOne({Key? key}) : super(key: key);

  @override
  State<SignUpStepOne> createState() => _SignUpStepOneState();
}

class _SignUpStepOneState extends State<SignUpStepOne> {
  bool _isLoading = false;
  RegExp regexExp = RegExp(r'^[\w-]+@[\w-]+\.\w+$');
  TextEditingController emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  // errors
  String? emailError;

  @override
  void dispose() {
    emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  Future<bool> validateEmail(String value) async {
    setState(() {
      _isLoading = true;
    });
    // match the email with the regex and set the error, if required
    bool matchedRegex = regexExp.hasMatch(value);
    bool emailInUseAlready = await Provider.of<UserProvider>(context, listen: false)
        .emailAlreadyExists(value)
        .then((value) => value);
    print('emailInUseAlready: ${emailInUseAlready}');
    setState(() {
      _isLoading = false;
    });
    print('matchedRegex: ${matchedRegex}, emailInUseAlready: ${emailInUseAlready}');
    if (!matchedRegex || emailInUseAlready) {
      setState(() {
        emailError = 'Please enter a valid email';
      });
      return matchedRegex && emailInUseAlready;
    }
    // else, remove it if regex is satisfied
    setState(() {
      emailError = null;
    });
    return matchedRegex && emailInUseAlready;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
        child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            // PARENT COLUMN
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s get you started',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppTextField(
                  height: 80.0,
                  label: "Email",
                  hint: "Please enter your email",
                  icon: Icons.alternate_email_outlined,
                  controller: emailController,
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
                Expanded(child: Container()),
                AppButton(
                    width: width,
                    height: Theme.of(context).buttonTheme.height,
                    title: 'Continue',
                    color: Theme.of(context).buttonTheme.colorScheme!.primary,
                    isEnabled: emailError == null,
                    isLoading: _isLoading,
                    loadingText: 'Loading...',
                    onPressed: () {
                      validateEmail(emailController.text).then((value) {
                        print('value: ${value}');
                        if (value) return;
                        userProvider.setUser('1', emailController.text);
                        Navigator.pushNamed(context, SignUpStepTwo.routeName);
                      });
                    }),
                const SizedBox(
                  height: 5,
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
                  height: 5,
                ),
                // the Social button
                AppButton(
                    width: width,
                    height: Theme.of(context).buttonTheme.height,
                    title: 'Use Social Signup Instead',
                    color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                    isEnabled: true,
                    isLoading: false,
                    loadingText: 'Loading...',
                    onPressed: () {
                      // openBottomModal(context, "Sign up");
                    }),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already registered? ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      GestureDetector(
                        child: Text(
                          'Log In',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignIn.routeName);
                        },
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
