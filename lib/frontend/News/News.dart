import 'package:flutter/material.dart';

import '../Common/NewsRender.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        // padding: EdgeInsets.fromLTRB(36, 64, 36, 12),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(36, 64, 36, 0),
              child: Text(
                'News',
                style: TextStyle(
                    color: Color(0xFF6FABD3),
                    fontSize: 28,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height: 0,),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                // color: Colors.transparent,
                // decoration:BoxDecoration(
                //
                // ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 64, 24, 40),
                  // scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NewsRender('Justin Bieber announces new concert dates for his.....', 'image_6'),
                      SizedBox(height: 64,),
                      NewsRender('Justin Bieber announces new concert dates for his.....', 'image_6'),
                      SizedBox(height: 64,),
                      NewsRender('Justin Bieber announces new concert dates for his.....', 'image_6'),
                      SizedBox(height: 64,),
                      NewsRender('Justin Bieber announces new concert dates for his.....', 'image_6'),
                      SizedBox(height: 64,),
                      NewsRender('Justin Bieber announces new concert dates for his.....', 'image_6'),
                      SizedBox(height: 64,),

                      NewsRender('Justin Bieber announces new concert dates for his.....', 'image_6'),
                      SizedBox(height: 32,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
