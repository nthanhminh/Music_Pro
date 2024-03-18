import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class RecentListening extends StatefulWidget {
  const RecentListening({super.key});

  @override
  State<RecentListening> createState() => _RecentListeningState();
}

class _RecentListeningState extends State<RecentListening> {
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
                  'Bài hát yêu thích',
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
                  '1 bài hát',
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.9),
                  ),
                ),
              ),
              Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/jack.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Thiên Lý Ơi',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('Jack - J97',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/11_11.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('11 Giờ 11 Phút',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('MiiNa - RIN9 - DREAMeR',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/gio.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Gió',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('Jank',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/way_back_home.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Way Back Home',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('Shaun',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/mat_moc.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Mặt Mộc',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('VAnh - Phạm Nguyên Ngọc',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Trời Giấu Trời Mang Đi',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('Amee - Viruss',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/fly_away.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Fly Away',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('The Fatrat',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/summertime.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Summertime',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('K-391',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 32, right: 16, bottom: 32),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/des/roi_ta_se_ngam_phao_hoa_cung_nhau.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text('Rồi ta sẽ ngắm pháo hoa cùng nhau',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                              ),
                              Container(
                                child: Text('O.Lew',
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Colors.grey.withOpacity(0.8),
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
                      Icon(
                        Icons.read_more,
                        color: Colors.red.withOpacity(0.7),
                        size: 32,
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
