import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:radio/frontend/User/UserSession.dart';
import '../Common/Playlist.dart';
import '../PlayList/PlayList.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List<Playlist> playlists = [];
  Future<List<Playlist>> fetchPlaylists(userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getPlaylistCreated?userId=$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Playlist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(UserSession().getUserId());
    fetchPlaylists(UserSession().getUserId()).then((data){
      setState(() {
        playlists = data;
        for(Playlist pl in data)
          {
            print("Id :${pl.playlistId}, name : ${pl.playlistName}, image :${pl.playlistImage}");
          }
      });
    }).catchError((e){
      print('Error when fetching data ${e}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100]?.withOpacity(0.7),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height, // Giá trị chiều cao tối thiểu
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.grey.withOpacity(0.9),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 32, top: 32, bottom: 32),
                  child: Text(
                    'Library',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black.withOpacity(0.65),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              SingleChildScrollView(
                padding: EdgeInsets.only(left: 32, right: 32, bottom: 32),
                scrollDirection: Axis.horizontal,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/FavouriteSong');
                        },
                        child: Container(
                          width: 150,
                          height: 100,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.blue.withOpacity(0.6),
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Bài hát yêu thích',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/FavouriteArtist');
                        },
                        child: Container(
                          width: 150,
                          height: 100,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.purple.withOpacity(0.8),
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Nghệ sĩ yêu thích',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/FavouritePlaylist');
                        },
                        child: Container(
                          width: 150,
                          height: 100,
                          padding: EdgeInsets.only(left: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.playlist_add_check,
                                color: Colors.orange.withOpacity(0.8),
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Playlist yêu thích',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 32),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 32),
                      child: Text(
                        'Nghe gần đây',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: Colors.grey.withOpacity(0.9),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/RecentListening');
                },
                child: Container(
                  padding: EdgeInsets.only(left: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/library/Recently-Played.jpg'),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 120,
                        height: 80,
                        child: Text(
                          'Bài hát nghe gần đây',
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 32, bottom: 32),
                child: Text(
                  'Playlist',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(children: [
                ...playlists.asMap().entries.map((e){
                  final playlist = e.value;
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => PlayList(playlist.playlistId,playlist.playlistName,playlist.playlistImage),
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 32),
                      margin: EdgeInsets.only(bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.network(playlist.playlistImage).image,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 80,
                            child: Text(
                              playlist.playlistName,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.85),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/NewPlayList');
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 32),
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/library/add.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: Text(
                            'Tạo Playlist',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.85),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
