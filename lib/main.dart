import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/game_bloc.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Match Game",
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: HomeScreen(),
      ),
    );
  }
}
