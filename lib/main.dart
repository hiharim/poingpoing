import 'package:flutter/material.dart';
import 'package:poingpoing_app/game/game_page.dart';
import 'package:poingpoing_app/home/home_page.dart';

void main() {
  runApp(const PoingPoingApp());
}

class PoingPoingApp extends StatelessWidget {
  const PoingPoingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoingPoing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8FD1FF),
          brightness: Brightness.light,
        ),
        fontFamily: 'Pretendard', // 있으면 쓰고, 없으면 알아서 교체
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/game': (_) => const GamePage(),
      },
    );
  }
}
