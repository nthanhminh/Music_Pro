import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MonthlyRank extends StatelessWidget {
  const MonthlyRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/MonthlyRanking');
              },
              child: Text(
                'Monthly Ranking',
                style: TextStyle(
                    color: Color(0xFF6FABD3),
                    fontSize: 24,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 24,
              ),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
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
                    offset: Offset(0, 1), // Điều chỉnh vị trí của bóng
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
                    SizedBox(width: 4,),
                    CircleAvatar(
                      backgroundColor: Color(0xFFF0F8FA),
                      radius: 4,
                    ),
                    SizedBox(width: 4,),
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
        SizedBox(height: 12,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xFFD5EAF5),
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF5BA3C9).withOpacity(1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(1, 1), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(-1, -3), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Color(0xFFE5F3FB).withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 17,
                      offset: Offset(-5, -6), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Color(0xFF568CAE).withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset(2, 6), // Điều chỉnh vị trí của bóng
                    ),
                  ]
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/image_1.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xFFD5EAF5),
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF5BA3C9).withOpacity(1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(1, 1), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(-1, -3), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Color(0xFFE5F3FB).withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 17,
                      offset: Offset(-5, -6), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Color(0xFF568CAE).withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset(2, 6), // Điều chỉnh vị trí của bóng
                    ),
                  ]
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/image_2.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xFFD5EAF5),
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF5BA3C9).withOpacity(1),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(1, 1), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(-1, -3), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Color(0xFFE5F3FB).withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 17,
                      offset: Offset(-5, -6), // Điều chỉnh vị trí của bóng
                    ),
                    BoxShadow(
                      color: Color(0xFF568CAE).withOpacity(1),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset(2, 6), // Điều chỉnh vị trí của bóng
                    ),
                  ]
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/image_3.png'),
              ),
            ),
          ],
        )
      ],
    );
  }
}