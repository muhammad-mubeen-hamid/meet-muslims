import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meet_muslims_client/components/button.dart';
import 'package:meet_muslims_client/components/text_field.dart';
import 'package:meet_muslims_client/models/error.dart';
import 'package:meet_muslims_client/pages/on_boarding.dart';
import 'package:meet_muslims_client/pages/sign_in.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class SignUpStepThree extends StatefulWidget {
  static const String routeName = '/sign_up_step_two';

  const SignUpStepThree({Key? key}) : super(key: key);

  @override
  State<SignUpStepThree> createState() => _SignUpStepThreeState();
}

class _SignUpStepThreeState extends State<SignUpStepThree> {
  bool _isLoading = false;
  RegExp regexExp = RegExp(r'^[\w-]+@[\w-]+\.\w+$');
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _contactNumberFocusNode = FocusNode();
  final PageController _pageController = PageController(initialPage: 0);

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

  void stopLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  void startLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  Future<bool> registerUser(String email) async {
    startLoader();
    AppNetworkResponse registered = await Provider.of<UserProvider>(context, listen: false)
        .registerUser(email, _passwordController.text, _contactNumberController.text)
        .then((value) => value);
    stopLoader();
    print(registered.httpCode);
    return registered.message == 'User registered successfully';
  }

  Widget pageOne(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Verify your contact number',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Icon(Icons.info_outline)
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        AppTextField(
            height: 80.0,
            label: "OTP",
            hint: "Please enter your OTP",
            icon: Icons.password,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            focusNode: _passwordFocusNode,
            errorText: emailError,
            onChanged: (value) {}
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget pageTwo(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Verify your email',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Icon(Icons.info_outline)
          ],
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
        Expanded(child: Container()),
      ],
    );
  }

  List<Widget> pages(BuildContext context) {
    return [
      pageOne(context),
      pageTwo(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            // PARENT COLUMN
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: pages(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: AppButton(
                      width: width,
                      height: Theme.of(context).buttonTheme.height,
                      title: 'Verify',
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                      isEnabled: emailError == null,
                      isLoading: _isLoading,
                      loadingText: 'Loading...',
                      onPressed: () {
                        _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.fastEaseInToSlowEaseOut);
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
