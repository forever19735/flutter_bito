import 'package:flutter/material.dart';
import 'package:flutter_bito/api_manager/api_provider.dart';
import 'package:flutter_bito/bloc/bito_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/bitoscreen/bito_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate Table(TWD)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, 
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BitoBloc>(
            create: (_) => BitoBloc(ApiProvider()),
          ),
        ],
        child: const BitoScreen(),
      ),
    );
  }
}
