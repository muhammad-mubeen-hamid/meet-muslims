import 'package:flutter/material.dart';
import 'package:meet_muslims_client/components/button.dart';
import 'package:meet_muslims_client/components/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width  = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(flex: 2,child: Container(),),
          Expanded(flex: 1,child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1,child: Text('Sign up', style: Theme.of(context).textTheme.headlineLarge,),),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppTextField(label: 'Email', controller: emailController, icon: Icons.alternate_email,),
                      AppButton(
                          width: width,
                          height: 40,
                          title: 'Continue',
                          color: Theme.of(context).buttonTheme.colorScheme?.primary,
                          onPressed: () => {}
                      ),
                      Text('Already registered with us?', style: Theme.of(context).textTheme.bodySmall,)
                    ],
                  ),
                ),
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
