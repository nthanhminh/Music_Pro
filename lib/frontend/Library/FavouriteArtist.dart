import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio/frontend/Common/Artist.dart';
import 'package:http/http.dart' as http;
import 'package:radio/frontend/User/UserSession.dart';

import '../API/API.dart';

class FavouriteArtist extends StatefulWidget {
  const FavouriteArtist({super.key});

  @override
  State<FavouriteArtist> createState() => _FavouriteArtistState();
}

class _FavouriteArtistState extends State<FavouriteArtist> {
  List<Artist> artists = [];
  API api = API();
  Future<List<Artist>> fetchArtists(userID) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getArtistFavourite?userId=$userID'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((json) => Artist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchArtists(UserSession().getUserId()).then((data) {
      setState(() {
        artists = data;
        print("day la du lieu lay tu server:");
        print(data);
        for (var song in data) {
          print("ID: ${song.artistId}, Name: ${song.artistName}, Image: ${song.artistImage}");
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
                  'Nghệ sĩ yêu thích',
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
                  '${artists.length} nghệ sĩ',
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              Column(children: [
                ...artists.asMap().entries.map((e){
                  final artist = e.value;
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
                              image: Image.network(artist.artistImage).image,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        Expanded(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(artist.artistName,
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
                        InkWell(
                          onTap: ()async{
                            await api.removeArtistFavourite(artist.removeId);
                            await fetchArtists(UserSession().getUserId()).then((value){
                              setState(() {
                                artists = value;
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
                  );
                }),
                // Container(
                //   padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                //   child: Row(
                //     children: [
                //       Container(
                //         width: 70,
                //         height: 70,
                //         margin: EdgeInsets.only(right: 16),
                //         decoration: BoxDecoration(
                //           image: DecorationImage(
                //             image: AssetImage('assets/Artist/jack.jpg'),
                //             fit: BoxFit.cover,
                //           ),
                //           borderRadius: BorderRadius.circular(60),
                //         ),
                //       ),
                //       Expanded(
                //         child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 child: Text('JACK - J97',
                //                     style: GoogleFonts.merriweather(
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.bold,
                //                       letterSpacing: 0.8,
                //                       color: Colors.black.withOpacity(0.8),
                //                     )),
                //               ),
                //             ]),
                //       ),
                //       Icon(
                //         Icons.favorite,
                //         color: Colors.purple.withOpacity(0.8),
                //       ),
                //       SizedBox(
                //         width: 12,
                //       ),
                //       Icon(
                //         Icons.read_more,
                //         color: Colors.red.withOpacity(0.7),
                //         size: 32,
                //       )
                //     ],
                //   ),
                // ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
