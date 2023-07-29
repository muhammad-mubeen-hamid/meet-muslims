import 'package:flutter/material.dart';
import 'package:meet_muslims_client/components/button.dart';
import 'package:meet_muslims_client/components/text_field.dart';
import 'package:meet_muslims_client/pages/on_boarding.dart';
import 'package:meet_muslims_client/pages/sign_in.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class SignUpStepTwo extends StatefulWidget {
  static const String routeName = '/sign_up_step_two';

  const SignUpStepTwo({Key? key}) : super(key: key);

  @override
  State<SignUpStepTwo> createState() => _SignUpStepTwoState();
}

class _SignUpStepTwoState extends State<SignUpStepTwo> {
  bool _isLoading = false;
  RegExp regexExp = RegExp(r'^[\w-]+@[\w-]+\.\w+$');
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _contactNumberFocusNode = FocusNode();

  // errors
  String? emailError;

  @override
  void dispose() {
    _passwordController.dispose();
    _contactNumberController.dispose();
    _passwordFocusNode.dispose();
    _contactNumberFocusNode.dispose();
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
                  label: "Password",
                  hint: "Please enter your desired password",
                  icon: Icons.password,
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  focusNode: _passwordFocusNode,
                  errorText: emailError,
                  onChanged: (value) {}
                ),
                AppTextField(
                  height: 80.0,
                  label: "Contact Number",
                  hint: "Please enter your contact number",
                  icon: Icons.phone,
                  controller: _contactNumberController,
                  keyboardType: TextInputType.phone,
                  focusNode: _contactNumberFocusNode,
                  errorText: emailError,
                  onChanged: (value) {
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
