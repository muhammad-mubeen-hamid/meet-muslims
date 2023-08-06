import 'package:flutter/material.dart';
import 'package:meet_muslims_client/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../components/button.dart';
import '../../components/text_field.dart';

class PhoneOTP extends StatefulWidget {
  const PhoneOTP({super.key});
  static const String routeName = '/phone_otp';

  @override
  State<PhoneOTP> createState() => _PhoneOTPState();
}

class _PhoneOTPState extends State<PhoneOTP> {
  bool _isLoading = false;
  String _loadingText = "";
  final TextEditingController _phoneOTPController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  String? otpError;

  void stopLoader() {
    setState(() {
      _loadingText = "";
      _isLoading = false;
    });
  }

  void startLoader(String message) {
    setState(() {
      otpError = null;
      _loadingText = message;
      _isLoading = true;
    });
  }

  bool validateField() {
    bool isValid = true;
    if (_phoneOTPController.text.isEmpty) {
      isValid = false;
      setState(() {
        otpError = 'Please enter the OTP sent to your phone number';
      });
      return isValid;
    }

    setState(() {
      otpError = null;
    });
    return isValid;
  }

  Future<bool> requestOTP(String username) async {
    bool isValid = false;
    startLoader("Requesting OTP...");
    final data = await Provider.of<UserProvider>(context, listen: false)
        .requestPhoneOTP(username);
    stopLoader();
    if (data.httpCode == 200) {
      isValid = true;
    } else {
      isValid = false;
    }
    return isValid;
  }

  Future<bool> validateOTP(String username) async {
    bool isValid = false;
    startLoader("Verifying OTP...");
    final data = await Provider.of<UserProvider>(context, listen: false)
        .validatePhoneOTP(username, _phoneOTPController.text);
    stopLoader();

    if (data.httpCode == 200) {
      isValid = true;
    } else if (data.httpCode == 400) {
      setState(() {
        otpError = data.message;
      });
    } else {
      setState(() {
        otpError = 'Something went wrong';
      });
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const Icon(Icons.warning_amber_rounded),
                                const SizedBox(width: 10,),
                                Text("Secure Your Account with OTP.", style: Theme.of(context).textTheme.headlineMedium,),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Text("Here's how it works:", style: Theme.of(context).textTheme.bodyMedium,),
                            const SizedBox(height: 10,),
                            Text("1. You'll receive an SMS with a unique OTP from us. 📱", style: Theme.of(context).textTheme.bodySmall,),
                            const SizedBox(height: 10,),
                            Text("2. Enter this OTP in the field displayed on your screen to proceed. This helps protect your account from unauthorized access. 🔒", style: Theme.of(context).textTheme.bodySmall,),
                            const SizedBox(height: 30,),
                            Text("Didn't receive the OTP? No worries!", style: Theme.of(context).textTheme.bodyMedium,),
                            Text("In case you haven't received the OTP, simply tap on 'Resend OTP' to get a new one. 🔄", style: Theme.of(context).textTheme.bodySmall,),
                            const SizedBox(height: 10,),
                            Text("If you have any questions or need assistance, don't hesitate to reach out to our support team.", style: Theme.of(context).textTheme.bodySmall,),
                            const SizedBox(height: 10,),
                            Text("Thank you for being part of our secure community! 🚀", style: Theme.of(context).textTheme.bodySmall,),
                          ],
                        ),
                      );
                    }, );
                  },
                    child: const Icon(Icons.info_outline)
                )
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
                isEnabled: _isLoading ? false : true,
                onChanged: (value) {
                  if (_isLoading) return;
                  validateField();
                },
                onSubmitted: (value) {
                  if (_isLoading) return;
                  final isValid = validateField();
                  if (isValid) {
                    validateOTP(userProvider.email);
                  }
                },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Didn't receive the OTP?", style: Theme.of(context).textTheme.bodySmall,),
                  const SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      requestOTP(userProvider.email).then((value) {
                        print('requestOTP value =========> $value');
                        if (!value) return;
                        WoltModalSheet.show(context: context, pageListBuilder: (context) => [
                          const SizedBox(height: 10,),
                          Text("OTP sent to your phone number", style: Theme.of(context).textTheme.bodyMedium,),
                          const SizedBox(height: 10,),
                          Text("Please enter the OTP sent to your phone number", style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(height: 10,),
                          Text("Didn't receive the OTP? No worries!", style: Theme.of(context).textTheme.bodyMedium,),
                          const SizedBox(height: 10,),
                          Text("In case you haven't received the OTP, simply tap on 'Resend OTP' to get a new one. 🔄", style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(height: 10,),
                          Text("If you have any questions or need assistance, don't hesitate to reach out to our support team.", style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(height: 10,),
                          Text("Thank you for being part of our secure community! 🚀", style: Theme.of(context).textTheme.bodySmall,),
                          const SizedBox(height: 10,),
                        ]
                      });
                    },
                    child: Text('Resend OTP', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),),
                  )
                ],
              ),
            ),
            Expanded(child: Container()),
            AppButton(
                width: width,
                height: Theme.of(context).buttonTheme.height,
                title: 'Verify',
                color: Theme.of(context).buttonTheme.colorScheme!.primary,
                isEnabled: otpError == null,
                isLoading: _isLoading,
                loadingText: _loadingText,
                onPressed: () {
                  if (_isLoading) return;
                  final isValid = validateField();
                  if (isValid) {
                    validateOTP(userProvider.email);
                  }
                },
            )
          ],
        ),
      ),
    );
  }
}
