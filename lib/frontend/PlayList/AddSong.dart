import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Common/Song.dart';
import './PlayList.dart';
import 'package:http/http.dart' as http;

class AddSong extends StatefulWidget {
  int playlistId;
  String playlistName;
  String playlistImg;
  AddSong(this.playlistId,this.playlistName,this.playlistImg);

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  var songs = [];
  var songAdded = [];

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

  Future<void> postData(input) async {
    final url = Uri.parse('http://10.0.2.2:8090/addNewSongToPlayList?playlistId=${widget.playlistId}&songId=$input');
    final response = await http.post(
      url,
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  }

  Future<List<int>> fetchSongsAdded(playlistId) async {
    String url = "http://10.0.2.2:8090/getSongAdded?playlistId=$playlistId";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchSong?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<int> songIds = data.map((json) => int.tryParse(json) ?? 0).toList();
      return songIds;
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSongsAdded(widget.playlistId).then((data) {
      setState(() {
        songAdded = data;
        for (int songId in data) {
          print(songId);
        }
      });
    }).catchError((onError) {
      print("Error occur when fetching data $onError");
    });
  }

  @override
  Widget build(BuildContext context) {
    var plalistId = ModalRoute.of(context)?.settings.arguments;
    // Đảm bảo GestureDetector bao bọc toàn bộ Scaffold để bắt sự kiện chạm ở mọi nơi
    return GestureDetector(
      onTap: () {
        // Đóng bàn phím khi chạm vào bất kỳ khu vực nào của màn hình ngoại trừ TextField
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      onHorizontalDragUpdate: (details){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      onVerticalDragUpdate: (details){
      FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(32),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PlayList(widget.playlistId,widget.playlistName,widget.playlistImg)));
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.withOpacity(0.9),
                      size: 36,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      margin: EdgeInsets.only(left: 32, right: 32),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 28,
                            color: Colors.grey.withOpacity(0.9),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              onChanged: (text) {
                                fetchSongs(text).then((data) {
                                  setState(() {
                                    songs = data;
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
                              },
                              decoration: InputDecoration(
                                hintText: 'Tìm kiếm bài hát',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                margin: EdgeInsets.only(left: 32, top: 32),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                height: 4,
                margin: EdgeInsets.only(top: 12),
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding:
                    EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    ...songs.asMap().entries.map((e) {
                      final song = e.value;
                      return Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: Image.network(song.songImage).image,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      song.songName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Container(
                                    child: Text(
                                      song.songAuthor,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.withOpacity(0.9),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // child:Icon(
                              //   Icons.add_circle_outline_sharp,
                              //   size: 36,
                              //   color: Colors.grey,
                              // ),
                              child: songAdded.contains(song.songId)
                                  ? Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 28,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.add_circle_outline_sharp,
                                        color: Colors.grey.withOpacity(0.8),
                                        size: 28,
                                      ),
                                      onPressed: () async {
                                        await postData(song.songId);
                                        fetchSongsAdded(widget.playlistId).then((data){
                                          setState(() {
                                            songAdded = data;
                                          });
                                        });
                                      },
                                    ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage('assets/des/jack.jpg'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Thiên Lý Ơi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  child: Text(
                                    'Jack - J97',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // child:Icon(
                            //   Icons.add_circle_outline_sharp,
                            //   size: 36,
                            //   color: Colors.grey,
                            // ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 32,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
