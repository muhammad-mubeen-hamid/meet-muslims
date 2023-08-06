import 'package:flutter/material.dart';

import '../../components/button.dart';
import '../../components/text_field.dart';

class EmailOTP extends StatefulWidget {
  const EmailOTP({super.key});
  static const String routeName = '/phone_otp';

  @override
  State<EmailOTP> createState() => _EmailOTPState();
}

class _EmailOTPState extends State<EmailOTP> {
  bool _isLoading = false;
  final TextEditingController _phoneOTPController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  String? otpError;

  bool validateField() {
    bool isValid = true;
    if (_phoneOTPController.text.isEmpty) {
      isValid = false;
      otpError = 'Please enter the OTP sent to your email';
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                icon: Icons.shield,
                controller: _phoneOTPController,
                keyboardType: TextInputType.visiblePassword,
                focusNode: _otpFocusNode,
                errorText: otpError,
                isEnabled: true,
                onChanged: (value) {}
            ),
            Expanded(child: Container()),
            AppButton(
                width: width,
                height: Theme.of(context).buttonTheme.height,
                title: 'Verify',
                color: Theme.of(context).buttonTheme.colorScheme!.primary,
                isEnabled: otpError == null,
                isLoading: _isLoading,
                loadingText: 'Loading...',
                onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
