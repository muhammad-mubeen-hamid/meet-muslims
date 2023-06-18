import 'package:flutter/material.dart';
import 'package:meet_muslims_client/pages/sign_up.dart';
import 'package:meet_muslims_client/provider/theme_provider.dart';
import 'package:meet_muslims_client/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meet Muslims',
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      home: const MyHomePage(title: 'Meet Muslims'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: Scaffold(
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
            child: const SafeArea(
                child: SignUp()
            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
