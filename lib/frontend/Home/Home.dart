import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/frontend/Home/MonthlyRank.dart';
import 'package:radio/frontend/Common/NewsRender.dart';
import 'package:radio/frontend/Home/PlaylistRender.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(36, 48, 36, 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Search');
                  },
                  icon: Icon(
                    Icons.search,
                    size: 36,
                    color: Color(0xFF6FABD3),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/Library');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0,horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                          Offset(0, 1), // Điều chỉnh vị trí của bóng
                        ),
                      ],
                    ),
                    child: Text(
                      'Library',
                      style: TextStyle(
                          color: Color(0xFF6FABD3),
                          fontSize: 24,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ]),
              SizedBox(height: 12,),
              // Monthly Ranking
              MonthlyRank(),
              SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/PopularPlaylist');
                        },
                        child: Text(
                          'Popular Playlist',
                          style: TextStyle(
                              color: Color(0xFF6FABD3),
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 24,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 1), // Điều chỉnh vị trí của bóng
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () => {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFFF0F8FA),
                                radius: 4,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xFFF0F8FA),
                                radius: 4,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xFFF0F8FA),
                                radius: 4,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PlaylistRender('Pop Playlist', 80, 'image_4'),
                      PlaylistRender('Top Beats', 40, 'image_5'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/News');
                        },
                        child: Text(
                          'News',
                          style: TextStyle(
                              color: Color(0xFF6FABD3),
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 24,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 1), // Điều chỉnh vị trí của bóng
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () => {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFFF0F8FA),
                                radius: 4,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xFFF0F8FA),
                                radius: 4,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xFFF0F8FA),
                                radius: 4,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NewsRender(
                          'Justin Bieber announces new concert dates for his.....',
                          'image_6'),
                      SizedBox(
                        height: 32,
                      ),
                      NewsRender(
                          'Watch Justin Bieber step in for Drake in DJ Khaled’s.....',
                          'image_7'),
                      SizedBox(
                        height: 32,
                      ),
                      NewsRender(
                          'Watch Justin Bieber step in for Drake in DJ Khaled’s.....',
                          'image_7'),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
