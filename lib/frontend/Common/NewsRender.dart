import 'package:flutter/material.dart';

class NewsRender extends StatelessWidget {
  String description;
  String image;

  NewsRender(this.description,this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18, 6, 36, 6),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB0D5EA), Color(0xFFC6E1F0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.white.withOpacity(0.6),
            width: 3,
            style: BorderStyle.solid,
            strokeAlign: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF7EB3CD).withOpacity(0.6),
              blurRadius: 16,
              offset: Offset(5,11),
            ),
            BoxShadow(
              color: Color(0xFFFFFFFF).withOpacity(0.6),
              blurRadius: 64,
              offset: Offset(-10,18),
            ),
            BoxShadow(
              color: Color(0xFFFFFFFF).withOpacity(0.6),
              blurRadius: 12,
              offset: Offset(0,0),
            ),
            BoxShadow(
              color: Color(0xFF9DC9E4).withOpacity(0.6),
              blurRadius: 12,
              offset: Offset(13,13),
            ),
            BoxShadow(
              color: Color(0xFFDDEEF6).withOpacity(0.6),
              blurRadius: 39,
              offset: Offset(-19,-27),
            ),
          ]
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/images/$image.png'),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Text(
              '$description',
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 1.2,
                color: Color(0xFF2368A4),
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
