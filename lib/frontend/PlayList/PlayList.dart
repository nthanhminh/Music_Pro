import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio/frontend/PlayList/AddSong.dart';

import '../API/API.dart';
import '../Common/Song.dart';
import 'package:http/http.dart' as http;

class PlayList extends StatefulWidget {
  int playListId;
  String playlistName;
  String playlistImg;

  PlayList(this.playListId, this.playlistName, this.playlistImg);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  double thumbnail_size = 200;
  API api = API();
  List<Song> songs = [];

  Future<List<Song>> fetchSongs(playlistId) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8090/getSongFromPlaylist?playlistId=$playlistId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }

  void update(playlistId) async {
    var data = await fetchSongs(playlistId);
    setState(() {
      songs = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update(widget.playListId);
  }

  @override
  Widget build(BuildContext context) {
    // var data;
    // data = ModalRoute.of(context)!.settings.arguments;
    // String? playlistName = data?['name'];
    // int? playlistId = data?["playlistId"];
    // print(data);
    // var namePlaylist = ModalRoute.of(context)?.settings.arguments;
    // int numberOfSongs = 0;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 32, bottom: 32, left: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil((route) => route.settings.name == '/Home');
                    Navigator.pushNamed(context, '/Library');
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 36,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: thumbnail_size,
                  height: thumbnail_size,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/des/jack.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ]),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.playlistName} - ${widget.playListId}',
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${songs.length} bài hát',
                    style: GoogleFonts.firaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSong(widget.playListId,
                                  widget.playlistName, widget.playlistImg)));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                      margin: EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        color: Colors.purple[600]?.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Text(
                        'Thêm bài hát',
                        style: GoogleFonts.firaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 18,
              ),
              ...songs.asMap().entries.map((e) {
                final index = e.key;
                final song = e.value;
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/MusicDisplay', arguments: {
                      'index': index,
                      'name': song.songName,
                      'songId': song.songId,
                      'author': song.songAuthor,
                      'imgUrl': song.songImage,
                      'musicUrl': song.songUrl,
                      'listSong': songs,
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 8),
                    margin: EdgeInsets.only(bottom: 18),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.network(song.songImage).image,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.songName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              Text(
                                song.songAuthor,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.play_arrow,
                          size: 36,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        IconButton(
                            onPressed: () async {
                              await api.removeSongFromPlayList(song.removeId);
                              var data = await api
                                  .fetchSongFromPlaylist(widget.playListId);
                              setState(() {
                                songs = data;
                              });
                            },
                            icon: Icon(
                              Icons.read_more,
                              color: Colors.red.withOpacity(0.7),
                              size: 32,
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
