import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:radio/frontend/User/UserSession.dart';

import '../Common/Playlist.dart';
import 'PlayList.dart';
class NewPlayList extends StatefulWidget {
  const NewPlayList({super.key});

  @override
  State<NewPlayList> createState() => _NewPlayListState();
}

class _NewPlayListState extends State<NewPlayList> {

  String _input = '';
  double submitButtonWidth = 320;
  late Playlist playlist;
  Future<Playlist> postData(input) async {
    final url = Uri.parse('http://10.0.2.2:8090/createNewPlayListByUser?userId=${UserSession().getUserId()}&name=$input');
    final response = await http.post(
      url,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Data sent successfully'); // Moved this line before the return statement
      return Playlist.fromJson(data);
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
      throw Exception('Failed to send data. Error code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(32),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 36,
                      color: Colors.grey.withOpacity(0.9),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Text(
                  'Tên Playlist',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: TextField(
                  autofocus: true,
                  onChanged: (value){
                    setState(() {
                      _input = value;
                    });
                  },
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 20,
            left: (MediaQuery.of(context).size.width - submitButtonWidth)/2,
            child: GestureDetector(
              onTap: () async {
                await postData(_input).then((data){
                  setState(() {
                    playlist = data;
                  });
                });
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayList(
                      playlist.playlistId,
                      playlist.playlistName,
                      playlist.playlistImage,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: submitButtonWidth,
                height: 50,
                decoration: BoxDecoration(
                  color: _input == '' ? Colors.grey.withOpacity(0.65) : Colors.purple[600]?.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(60),
                ),
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 28),
                child: Text(
                  'Tạo PlayList mới',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: _input == '' ? Colors.white.withOpacity(0.6) : Colors.white.withOpacity(0.95),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
