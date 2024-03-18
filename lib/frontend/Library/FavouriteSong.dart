import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../API/API.dart';
import '../Common/Song.dart';
import '../User/UserSession.dart';

class FavouriteSong extends StatefulWidget {
  const FavouriteSong({super.key});

  @override
  State<FavouriteSong> createState() => _FavouriteSongState();
}

class _FavouriteSongState extends State<FavouriteSong> {
  List<Song> songs = [];
  API api = API();
  Future<List<Song>> fetchSongs(userID) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getSongFavourite?userId=$userID'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(UserSession().getUserId());
    fetchSongs(UserSession().getUserId()).then((data) {
      setState(() {
        songs = data;
        print("day la du lieu lay tu server:");
        print(data);
        for (var song in data) {
          print("ID: ${song.songId}, Name: ${song.songName}, Image: ${song.songImage}, URL: ${song.songUrl}, removeId: ${song.removeId}");
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
                  'Bài hát yêu thích',
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
                  '${songs.length} bài hát',
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              Column(children: [
                ...songs.asMap().entries.map((e){
                  final index = e.key;
                  final song = e.value;
                  return GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/MusicDisplay', arguments: {
                        'index': index,
                        'name' : song.songName,
                        'songId': song.songId,
                        'author': song.songAuthor,
                        'imgUrl': song.songImage,
                        'musicUrl' : song.songUrl,
                        'listSong' : songs,
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.network(song.songImage).image,
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
                                    child: Text(song.songName,
                                        style: GoogleFonts.merriweather(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                          color: Colors.black.withOpacity(0.8),
                                        )),
                                  ),
                                  Container(
                                    child: Text(song.songAuthor,
                                        style: GoogleFonts.merriweather(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                          color: Colors.grey.withOpacity(0.8),
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
                          InkWell(
                            onTap: ()async{
                              await api.removeSongFromFavourite(song.removeId);
                              await fetchSongs(UserSession().getUserId()).then((data){
                                setState(() {
                                  songs = data;
                                });
                              });
                            },
                            child: Icon(
                              Icons.read_more,
                              color: Colors.red.withOpacity(0.7),
                              size: 32,
                            ),
                          )
                        ],
                      ),
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
