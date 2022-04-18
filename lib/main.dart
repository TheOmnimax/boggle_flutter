import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/bloc/bloc.dart';
import 'package:boggle_flutter/firebase_options.dart';
import 'package:boggle_flutter/screens/home_screen/home_screen.dart';
import 'package:boggle_flutter/screens/create_game_screen/create_game_screen.dart';
import 'package:boggle_flutter/screens/home_screen/home_screen.dart';
import 'package:boggle_flutter/screens/board_screen/board_screen.dart';

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        // '/create': (context) => const CreateGame(),
        // '/board': (context) => const BoardScreen(),
      },
    );
  }
}
