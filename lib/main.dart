import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/firebase_options.dart';
import 'package:boggle_flutter/screens/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc()..add(const AppOpened()),
      child: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boggle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'LexandDeca',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
