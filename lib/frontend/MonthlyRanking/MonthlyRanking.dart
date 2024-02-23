import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class MonthlyRanking extends StatefulWidget {
  const MonthlyRanking({super.key});

  @override
  State<MonthlyRanking> createState() => _MonthlyRankingState();
}

class _MonthlyRankingState extends State<MonthlyRanking> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: mediaQueryData.size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(32, 12, 32, 64),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32,48,32,0),
                  child: Text(
                    'Monthly Ranking',
                    style: TextStyle(
                      color: Color(0xFF6FABD3),
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(height: 28,),
                Stack(
                  children: [
                      Container(
                    constraints: BoxConstraints(
                      minWidth:mediaQueryData.size.width -64,
                      minHeight: 170,
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/image_10.png'),
                          fit: BoxFit.fill,
                        ),
                        gradient: LinearGradient(
                          colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.6),
                            blurRadius: 4,
                            offset: Offset(0,4),
                          ),
                          BoxShadow(
                            color: Color(0xFFFFFFFF).withOpacity(0.6),
                            blurRadius:22,
                            offset: Offset(-10,-10),
                          ),
                          BoxShadow(
                            color: Color(0xFF76B4CD).withOpacity(0.6),
                            blurRadius:22,
                            offset: Offset(10,10),
                          ),
                          BoxShadow(
                            color: Color(0xFFFFFFFF).withOpacity(0.6),
                            blurRadius: 2,
                            offset: Offset(-5,0),
                          ),
                        ],
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                              colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ),
                          width: 6,
                        )
                    ),
                  ),
                      Positioned(
                        bottom: 32,
                        left: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(
                              'Popular Playlist',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 22,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height:2,),
                            Text(
                              '80 songs',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                              ),
                            ),
                          ]
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth:mediaQueryData.size.width -64,
                              minHeight: 170,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )
                      )
                  ]
                ),
                SizedBox(height: 28,),
                Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minWidth:mediaQueryData.size.width -64,
                          minHeight: 170,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/image_9.png'),
                              fit: BoxFit.fill,
                            ),
                            gradient: LinearGradient(
                              colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.6),
                                blurRadius: 4,
                                offset: Offset(0,4),
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                blurRadius:22,
                                offset: Offset(-10,-10),
                              ),
                              BoxShadow(
                                color: Color(0xFF76B4CD).withOpacity(0.6),
                                blurRadius:22,
                                offset: Offset(10,10),
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                blurRadius: 2,
                                offset: Offset(-5,0),
                              ),
                            ],
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                              width: 6,
                            )
                        ),
                      ),
                      Positioned(
                        bottom: 32,
                        left: 24,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                'Popular Playlist',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 22,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height:2,),
                              Text(
                                '80 songs',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ]
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth:mediaQueryData.size.width -64,
                              minHeight: 170,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )
                      )
                    ]
                ),
                SizedBox(height: 28,),
                Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minWidth:mediaQueryData.size.width -64,
                          minHeight: 170,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/image_8.png'),
                              fit: BoxFit.fill,
                            ),
                            gradient: LinearGradient(
                              colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.6),
                                blurRadius: 4,
                                offset: Offset(0,4),
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                blurRadius:22,
                                offset: Offset(-10,-10),
                              ),
                              BoxShadow(
                                color: Color(0xFF76B4CD).withOpacity(0.6),
                                blurRadius:22,
                                offset: Offset(10,10),
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                blurRadius: 2,
                                offset: Offset(-5,0),
                              ),
                            ],
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                              width: 6,
                            )
                        ),
                      ),
                      Positioned(
                        bottom: 32,
                        left: 24,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                'Popular Playlist',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 22,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height:2,),
                              Text(
                                '80 songs',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ]
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth:mediaQueryData.size.width -64,
                              minHeight: 170,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )
                      )
                    ]
                ),
                SizedBox(height: 28,),
                Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minWidth:mediaQueryData.size.width -64,
                          minHeight: 170,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/image_8.png'),
                              fit: BoxFit.fill,
                            ),
                            gradient: LinearGradient(
                              colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.6),
                                blurRadius: 4,
                                offset: Offset(0,4),
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                blurRadius:22,
                                offset: Offset(-10,-10),
                              ),
                              BoxShadow(
                                color: Color(0xFF76B4CD).withOpacity(0.6),
                                blurRadius:22,
                                offset: Offset(10,10),
                              ),
                              BoxShadow(
                                color: Color(0xFFFFFFFF).withOpacity(0.6),
                                blurRadius: 2,
                                offset: Offset(-5,0),
                              ),
                            ],
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                  colors: [Color(0xFFDAEFF8),Color(0xFFC8E4F1)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              ),
                              width: 6,
                            )
                        ),
                      ),
                      Positioned(
                        bottom: 32,
                        left: 24,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Text(
                                'Popular Playlist',
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 22,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height:2,),
                              Text(
                                '80 songs',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ]
                        ),
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth:mediaQueryData.size.width -64,
                              minHeight: 170,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          )
                      )
                    ]
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
