import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PlaylistRender extends StatelessWidget {
  String name;

  int numberOfSongs;

  String image;

  PlaylistRender(this.name,this.numberOfSongs, this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC8E4F1), Color(0xFFDAEFF8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 22,
              blurStyle: BlurStyle.normal,
              offset: Offset(-10,-10),
            ),
            BoxShadow(
              color: Color(0xFF76B4CD).withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 22,
              blurStyle: BlurStyle.inner,
              offset: Offset(10,10),
            ),
            BoxShadow(
              color: Color(0xFFFFFFFF).withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 2,
              blurStyle: BlurStyle.outer,
              offset: Offset(-5,0),
            ),
            BoxShadow(
              color: Color(0xFFA6CEE0).withOpacity(0.6),
              spreadRadius: 0,
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
              offset: Offset(4,4),
            ),
          ]
      ),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 180,
              minWidth: 106,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/$image.png'),
                  fit: BoxFit.fill,
                )
            ),
          ),
          SizedBox(height: 16,),
          GradientText(
            '$name',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            gradientType: GradientType.linear,
            radius: 2.5,
            colors: [
              Color(0xFF000000).withOpacity(0.8),
              Color(0xFF000A1E).withOpacity(0.8),
              Color(0xFF002369).withOpacity(0.8)
            ],
          ),
          Text(
            '$numberOfSongs songs',
            style: TextStyle(
              color: Color(0xFF70ACD3),
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}