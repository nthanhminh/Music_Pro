import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio/frontend/Common/Playlist.dart';
import 'package:http/http.dart' as http;

import '../User/UserSession.dart';
class FavouritePlaylist extends StatefulWidget {
  const FavouritePlaylist({super.key});

  @override
  State<FavouritePlaylist> createState() => _FavouritePlaylistState();
}

class _FavouritePlaylistState extends State<FavouritePlaylist> {
  List<Playlist> playlists = [];
  Future<List<Playlist>> fetchPlaylists(userID) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getPlayListFavourite?userId=$userID'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Playlist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPlaylists(UserSession().getUserId()).then((data) {
      setState(() {
        playlists = data;
        print("day la du lieu lay tu server:");
        print(data);
        for (var song in data) {
          print("ID: ${song.playlistId}, Name: ${song.playlistName}, Image: ${song.playlistImage}");
        }
      });
    }).catchError((error) {
      print("Lỗi khi lấy dữ liệu từ máy chủ: $error");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding:
                EdgeInsets.only(left: 32, top: 32, right: 32, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          size: 36,
                          color: Colors.grey.withOpacity(0.9),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/Home');
                        },
                        icon: Icon(
                          Icons.home,
                          size: 36,
                          color: Colors.grey.withOpacity(0.9),
                        )),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 32, bottom: 32),
                child: Text(
                  'Playlist yêu thích',
                  style: GoogleFonts.merriweather(
                    fontSize: 24,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 32, bottom: 32),
                child: Text(
                  '${playlists.length} playlist',
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              Column(children: [
                ...playlists.asMap().entries.map((e){
                  final playlist = e.value;
                  return Container(
                    padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.network(playlist.playlistImage).image,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(playlist.playlistName,
                                      style: GoogleFonts.merriweather(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        color: Colors.black.withOpacity(0.8),
                                      )),
                                ),
                              ]),
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.purple.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.read_more,
                          color: Colors.red.withOpacity(0.7),
                          size: 32,
                        )
                      ],
                    ),
                  );
                }),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
