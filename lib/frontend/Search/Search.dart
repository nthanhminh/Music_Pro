import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio/frontend/Search/SearchResult.dart';
import 'package:http/http.dart' as http;

import '../API/API.dart';
import '../Common/Artist.dart';
import '../Common/Playlist.dart';
import '../Common/Song.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String input_text = '';
  bool _is_submitted = false;
  List<Song> data = [];
  List<Playlist> playlists = [];
  List<Artist> artists = [];
  List<int> songFavourites = [];
  API api = API();
  Future<List<Song>> fetchSongs(searchInput) async {
    String url = "http://10.0.2.2:8090/searchSong?searchInput=$searchInput";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchSong?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<Playlist>> fetchPlayList(searchInput) async {
    String url = "http://10.0.2.2:8090/searchPlayList?searchInput=$searchInput";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchPlayList?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Playlist.fromJson(json)).toList();
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<Artist>> fetchArtist(searchInput) async {
    String url = "http://10.0.2.2:8090/searchArtist?searchInput=$searchInput";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchPlayList?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Artist.fromJson(json)).toList();
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Bao Scaffold bằng GestureDetector
    return GestureDetector(
      onTap: () {
        // Đây là cách ẩn bàn phím khi nhấn vào bất kỳ vùng nào trên màn hình ngoại trừ TextField
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 32, left: 0, right: 0, bottom: 0),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   // colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
              //   // colors: Colors.white.withOpacity(opacity),
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   stops: [0.0, 1.0],
              //   tileMode: TileMode.clamp,
              // ),
              color: Colors.white.withOpacity(0.6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 32, left: 6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_sharp),
                      color: Colors.grey.withOpacity(0.9),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          // Màu nền của Container
                          borderRadius: BorderRadius.circular(60),
                          // Bo tròn góc
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12, right: 6),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search_sharp,
                                    size: 32,
                                    color: Colors.black.withOpacity(0.4),
                                  )),
                            ),
                            Expanded(
                              child: TextField(
                                onSubmitted: (value) {
                                  setState(() {
                                    _is_submitted = true;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    _is_submitted = false;
                                  });
                                },
                                autofocus: true,
                                autocorrect: true,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 20,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w400,
                                ),
                                cursorColor: Colors.black.withOpacity(0.8),
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2,
                                  ),
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  // Ẩn đường viền khi TextField được focus
                                  enabledBorder: InputBorder.none,
                                  // Ẩn đường viền khi TextField được enable (sẵn sàng để nhập văn bản)
                                  disabledBorder: InputBorder.none,
                                  // Ẩn đường viền khi TextField bị disable
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  fetchSongs(text).then((songs) {
                                    setState(() {
                                      data = songs;
                                      print("day la du lieu lay tu server:");
                                      print(data);
                                      for (var song in data) {
                                        print(
                                            "ID: ${song.songId},Author: ${song.songAuthor}, Name: ${song.songName}, Image: ${song.songImage}, URL: ${song.songUrl}");
                                      }
                                    });
                                  }).catchError((error) {
                                    print(
                                        "Lỗi khi lấy dữ liệu từ máy chủ: $error");
                                  });
                                  setState(() {
                                    input_text = text;
                                  });

                                  fetchPlayList(text).then((data) {
                                    setState(() {
                                      playlists = data;
                                      print("day la du lieu lay tu server:");
                                      // print(data);
                                      for (var artist in data) {
                                        print(
                                            "ID: ${artist.playlistId},Name: ${artist.playlistName}, Image: ${artist.playlistImage}");
                                      }
                                    });
                                  }).catchError((error) {
                                    print(
                                        "Lỗi khi lấy dữ liệu từ máy chủ: $error");
                                  });

                                  fetchArtist(text).then((data) {
                                    setState(() {
                                      artists = data;
                                      print("day la du lieu lay tu server:");
                                      // print(data);
                                      for (var artist in data) {
                                        print(
                                            "ID: ${artist.artistId},Name: ${artist.artistName}, Image: ${artist.artistImage}");
                                      }
                                    });
                                  }).catchError((error) {
                                    print(
                                        "Lỗi khi lấy dữ liệu từ máy chủ: $error");
                                  });

                                  print(input_text);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              !_is_submitted
                  ? (input_text == ''
                      ? Container(
                          padding: EdgeInsets.only(left: 32),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đề xuất cho bạn',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Wrap(
                                  spacing: 12.0,
                                  runSpacing: 16.0,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Thiên lý ơi',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.9),
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Có lẽ bên nhau là sai',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.9),
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Thủy triều',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.9),
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Just say hello',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.9),
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Hello',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.9),
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Pround of you',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.9),
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),
                        )
                      : Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 32),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 32),
                                    child: Column(
                                      children: [
                                        ...data
                                            .asMap()
                                            .entries
                                            .take(3)
                                            .map((entry) {
                                          final index = entry.key;
                                          final song = entry.value;

                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 4),
                                            margin: EdgeInsets.only(bottom: 12),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                  // Màu sắc của đường viền
                                                  width:
                                                      1.0, // Độ dày của đường viền
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  Icons.search_sharp,
                                                  color: Colors.grey
                                                      .withOpacity(0.6),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  '${song.songName}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                  ...data.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final song = entry.value;
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/MusicDisplay', arguments: {
                                          'index': index,
                                          'name': song.songName,
                                          'songId': song.songId,
                                          'author': song.songAuthor,
                                          'imgUrl': song.songImage,
                                          'musicUrl': song.songUrl,
                                          'listSong': data,
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 32),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: Image.network(
                                                      song.songImage).image,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    song.songName,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight: FontWeight.bold,
                                                      letterSpacing: 0.6,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    song.songAuthor,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.normal,
                                                      letterSpacing: 0.4,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.play_arrow,
                                                size: 36,
                                                color: Colors.grey.withOpacity(0.8),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.more_vert,
                                                size: 36,
                                                color: Colors.grey.withOpacity(0.8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  // Container(
                                  //   child: Row(
                                  //     children: [
                                  //       Container(
                                  //         width: 60,
                                  //         height: 60,
                                  //         decoration: BoxDecoration(
                                  //           image: DecorationImage(
                                  //             image: AssetImage(
                                  //                 'assets/des/troi_giau_troi_mang_di.jpg'),
                                  //             fit: BoxFit.cover,
                                  //           ),
                                  //           borderRadius:
                                  //               BorderRadius.circular(8),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 12,
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text(
                                  //             'Trời giấu trời mang đi',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 17,
                                  //               fontWeight: FontWeight.bold,
                                  //               letterSpacing: 0.6,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             'Amee - Viruss',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.normal,
                                  //               letterSpacing: 0.4,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         width: 12,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.play_arrow,
                                  //           size: 36,
                                  //           color: Colors.grey.withOpacity(0.8),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 0,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.more_vert,
                                  //           size: 36,
                                  //           color: Colors.grey.withOpacity(0.8),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 32,
                                  // ),
                                  // Container(
                                  //   child: Row(
                                  //     children: [
                                  //       Container(
                                  //         width: 60,
                                  //         height: 60,
                                  //         decoration: BoxDecoration(
                                  //           image: DecorationImage(
                                  //             image: AssetImage(
                                  //                 'assets/des/troi_giau_troi_mang_di.jpg'),
                                  //             fit: BoxFit.cover,
                                  //           ),
                                  //           borderRadius:
                                  //               BorderRadius.circular(8),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 12,
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text(
                                  //             'Trời giấu trời mang đi',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 17,
                                  //               fontWeight: FontWeight.bold,
                                  //               letterSpacing: 0.6,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             'Amee - Viruss',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.normal,
                                  //               letterSpacing: 0.4,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         width: 12,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.play_arrow,
                                  //           size: 36,
                                  //           color: Colors.grey.withOpacity(0.8),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 0,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.more_vert,
                                  //           size: 36,
                                  //           color: Colors.grey.withOpacity(0.8),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 32,
                                  // ),
                                  // Container(
                                  //   child: Row(
                                  //     children: [
                                  //       Container(
                                  //         width: 60,
                                  //         height: 60,
                                  //         decoration: BoxDecoration(
                                  //           image: DecorationImage(
                                  //             image: AssetImage(
                                  //                 'assets/des/troi_giau_troi_mang_di.jpg'),
                                  //             fit: BoxFit.cover,
                                  //           ),
                                  //           borderRadius:
                                  //               BorderRadius.circular(8),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 12,
                                  //       ),
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           Text(
                                  //             'Trời giấu trời mang đi',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 17,
                                  //               fontWeight: FontWeight.bold,
                                  //               letterSpacing: 0.6,
                                  //             ),
                                  //           ),
                                  //           Text(
                                  //             'Amee - Viruss',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 15,
                                  //               fontWeight: FontWeight.normal,
                                  //               letterSpacing: 0.4,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       SizedBox(
                                  //         width: 12,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.play_arrow,
                                  //           size: 36,
                                  //           color: Colors.grey.withOpacity(0.8),
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         width: 0,
                                  //       ),
                                  //       IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           Icons.more_vert,
                                  //           size: 36,
                                  //           color: Colors.grey.withOpacity(0.8),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 32,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ))
                  : SearchResult(data,playlists,artists), //suggestion box
            ],
          ),
        ),
      ),
    );
  }
}
