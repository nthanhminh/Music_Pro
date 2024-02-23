import 'package:flutter/material.dart';
import 'package:radio/frontend/MonthlyRanking/MonthlyRanking.dart';
import 'package:radio/frontend/MusicPlayerDisplay/MusicPlayerDisplay.dart';
import 'package:radio/frontend/RadioChart/RadioChart.dart';
import 'package:radio/frontend/Search/Search.dart';
import 'package:radio/frontend/Search/SearchResult.dart';
import 'frontend/Home/MonthlyRank.dart';
import 'frontend/Home/Home.dart';
import 'frontend/News/News.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/Home': (context) => Home(),
        '/News': (context) => News(),
        '/Search': (context) => SearchPage(),
        '/SearchResult': (context) => SearchResult(),
        '/MusicDisplay': (context) => MusicPlayerDisplay(),
        '/MonthlyRanking': (context) => MonthlyRanking(),
        '/PopularPlaylist': (context) => RadioChart(),
      },
    );
  }
}

