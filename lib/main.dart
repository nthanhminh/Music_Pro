import 'package:flutter/material.dart';
import 'package:radio/frontend/Library/FavouriteArtist.dart';
import 'package:radio/frontend/Library/FavouriteSong.dart';
import 'package:radio/frontend/Library/Library.dart';
import 'package:radio/frontend/Library/RecentListening.dart';
import 'package:radio/frontend/Login/Login.dart';
import 'package:radio/frontend/MonthlyRanking/MonthlyRanking.dart';
import 'package:radio/frontend/MusicPlayerDisplay/MusicPlayerDisplay.dart';
import 'package:radio/frontend/PlayList/AddSong.dart';
import 'package:radio/frontend/PlayList/NewPlayList.dart';
import 'package:radio/frontend/RadioChart/RadioChart.dart';
import 'package:radio/frontend/Search/Search.dart';
import 'package:radio/frontend/Search/SearchResult.dart';
import 'frontend/Home/Home.dart';
import 'frontend/Library/FavouritePlaylist.dart';
import 'frontend/Login/Signin.dart';
import 'frontend/News/News.dart';
import 'frontend/PlayList/PlayList.dart';

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
        '/': (context) => Login(),
        '/Home': (context) => Home(),
        '/News': (context) => News(),
        '/NewPlayList': (context) => NewPlayList(),
        // '/PlayList': (context) => PlayList(),
        '/Search': (context) => SearchPage(),
        '/SearchResult': (context) => SearchResult.none(),
        '/MusicDisplay': (context) => MusicPlayerDisplay(),
        '/MonthlyRanking': (context) => MonthlyRanking(),
        '/PopularPlaylist': (context) => RadioChart(),
        // '/AddSong': (context) => AddSong(),
        '/Library' : (context) => Library(),
        '/FavouriteSong': (context) => FavouriteSong(),
        '/FavouriteArtist': (context) => FavouriteArtist(),
        '/FavouritePlaylist': (context) => FavouritePlaylist(),
        '/RecentListening': (context) => RecentListening(),
      },
    );
  }
}

