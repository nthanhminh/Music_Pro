import 'package:flutter/material.dart';
import 'package:radio/frontend/MusicPlayer/MusicPlayer.dart';
import 'package:radio/frontend/RadioChart/SongRender.dart';

class RadioChart extends StatefulWidget {
  const RadioChart({super.key});

  @override
  State<RadioChart> createState() => _RadioChartState();
}

class _RadioChartState extends State<RadioChart> {

  bool isReadingMoreTurnOn = true;
  int limit = 5;

  List<Map<String,dynamic>> fakeData =[
    {
      'index' : 1,
      'name'  : 'Trời giấu trời mang đi',
      'author': 'Amee - Viruss',
      'imgUrl': 'assets/des/troi_giau_troi_mang_di.jpg',
      'songUrl': 'music/troigiautroimangdi.mp3'
    },
    {
      'index' : 2,
      'name'  : "11 giờ 11 phút",
      'author': 'Miina - RIN9 - DREAMer',
      'imgUrl': 'assets/des/11_11.jpg',
      'songUrl': 'music/11h11p.mp3'
    },
    {
      'index' : 3,
      'name'  : 'Mặt mộc',
      'author': 'Vanh - Phạm Nguyên Ngọc',
      'imgUrl': 'assets/des/mat_moc.jpg',
      'songUrl': 'music/matmoc.mp3'
    },
    {
      'index' : 4,
      'name'  : 'Em đồng ý',
      'author': 'Đức Phúc - 911',
      'imgUrl': 'assets/des/em_dong_y.jpg',
      'songUrl': 'music/emdongy.mp3'
    },
    {
      'index' : 5,
      'name'  : 'Monody',
      'author': 'The Fatrat',
      'imgUrl': 'assets/des/fly_away.jpg',
      'songUrl': 'music/flyaway.mp3'
    },
    {
      'index' : 6,
      'name'  : 'Summer Time',
      'author': 'K - 391',
      'imgUrl': 'assets/des/summertime.jpg',
      'songUrl': 'music/SummerTime.mp3'
    },
    {
      'index' : 7,
      'name'  : 'Gió (Lofi-ver)',
      'author': 'Jank',
      'imgUrl': 'assets/des/gio.jpg',
      'songUrl': 'music/giolofi.mp3'
    },
    {
      'index' : 8,
      'name'  : 'Way back home',
      'author': 'Shaun',
      'imgUrl': 'assets/des/way_back_home.jpg',
      'songUrl': 'music/waybackhome.mp3'
    },
    {
      'index' : 9,
      'name'  : 'Pround Of You',
      'author': 'Fiona Fung',
      'imgUrl': 'assets/des/zingAvatar.jpg',
      'songUrl': 'music/proudOfYou.mp3'
    },
    {
      'index' : 10,
      'name'  : 'Tây Lâu Biệt Tự',
      'author': '澤典 / Trạch Điển',
      'imgUrl': 'assets/des/tay_lau.jpg',
      'songUrl': 'music/TayLauBietTu.mp3'
    },
    {
      'index' : 11,
      'name'  : 'Beautiful In White',
      'author': 'West Life',
      'imgUrl': 'assets/des/zingAvatar.jpg',
      'songUrl': 'music/beautifulInWhite.mp3'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
        Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
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
              padding: EdgeInsets.fromLTRB(24, 4, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                  [
                    Padding(
                      padding: EdgeInsets.fromLTRB(32, 48, 32, 32),
                      child: Text(
                        'Radio Chart',
                        style: TextStyle(
                            fontSize: 28,
                            color: Color(0xFF6FABD3),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...fakeData.map((songs){
                      if(isReadingMoreTurnOn == true && songs['index'] > limit)
                      {
                          return SizedBox();
                      }
                      return SongRender(songs['index'], songs['name'], songs['author'], songs['imgUrl'], songs['songUrl'],fakeData);
                    }).toList(),
                    // SongRender(1, 'Trời giấu trời mang điaaaa', 'Amee - Viruss',
                    //     'assets/des/troi_giau_troi_mang_di.jpg'),
                    // SongRender(2, '11 giờ 11 phút', 'Miina - RIN9 - DREAMer',
                    //     'assets/des/11_11.jpg'),
                    // SongRender(3, 'Mặt mộc', 'Vanh - Phạm Nguyên Ngọc',
                    //     'assets/des/mat_moc.jpg'),
                    // SongRender(4, 'Em đồng ý', 'Đức Phúc - 911',
                    //     'assets/des/em_dong_y.jpg'),
                    // SongRender(
                    //     5, 'Monody', 'The Fatrat', 'assets/des/fly_away.jpg'),
                    // SongRender(
                    //     6, 'Summer Time', 'K - 391', 'assets/des/summertime.jpg'),
                    // SongRender(
                    //     6, 'Summer Time', 'K - 391', 'assets/des/summertime.jpg'),
                    // SongRender(
                    //     6, 'Summer Time', 'K - 391', 'assets/des/summertime.jpg'),
                  ],
                ),
            )
        ),
          isReadingMoreTurnOn == false ? SizedBox() : Positioned(
          bottom: 16,
          child: TextButton(
            onPressed: (){
              setState(() {
                isReadingMoreTurnOn = !isReadingMoreTurnOn;
                limit = fakeData.length;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB0D5EA), Color(0xFFC6E1F0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.circular(30),
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
                      offset: Offset(5, 11),
                    ),
                    BoxShadow(
                      color: Color(0xFFFFFFFF).withOpacity(0.6),
                      blurRadius: 64,
                      offset: Offset(-10, 18),
                    ),
                    BoxShadow(
                      color: Color(0xFFFFFFFF).withOpacity(0.6),
                      blurRadius: 12,
                      offset: Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Color(0xFF9DC9E4).withOpacity(0.6),
                      blurRadius: 12,
                      offset: Offset(13, 13),
                    ),
                    BoxShadow(
                      color: Color(0xFFDDEEF6).withOpacity(0.6),
                      blurRadius: 39,
                      offset: Offset(-19, -27),
                    ),
                  ]),
              child: Text(
                'Read more',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.green.withOpacity(0.6)
                ),
              ),
            )
          ),
        )
        ],
      ),
    );
  }
}
