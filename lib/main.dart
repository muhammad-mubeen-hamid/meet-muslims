import 'package:flutter/material.dart';
import 'package:meet_muslims_client/pages/landing.dart';
import 'package:meet_muslims_client/pages/on_boarding.dart';
import 'package:meet_muslims_client/pages/sign_in.dart';
import 'package:meet_muslims_client/pages/sign_up_step_one.dart';
import 'package:meet_muslims_client/pages/sign_up_step_three.dart';
import 'package:meet_muslims_client/pages/sign_up_step_two.dart';
import 'package:meet_muslims_client/provider/theme_provider.dart';
import 'package:meet_muslims_client/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  if (const bool.fromEnvironment('dart.vm.prod')) {

  } else if (const bool.fromEnvironment('dart.vm.staging')) {

  } else {
    runApp(
        ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
            child: ChangeNotifierProvider(
                create: (_) => UserProvider(),
                child: const MyApp()
            )
        )
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meet Muslims',
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      initialRoute: SignUpStepThree.routeName,
      routes: {
        Landing.routeName: (context) => const Landing(),
        SignIn.routeName: (context) => const SignIn(),
        SignUpStepOne.routeName: (context) => const SignUpStepOne(),
        SignUpStepTwo.routeName: (context) => const SignUpStepTwo(),
        SignUpStepThree.routeName: (context) => const SignUpStepThree(),
        OnBoarding.routeName: (context) => const OnBoarding(),
      },
    );
  }
}
