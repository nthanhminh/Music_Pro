import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> with SingleTickerProviderStateMixin {

  int current_index = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener((){
      print(_tabController.index);
      setState(() {
        current_index = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         IconButton(
    //             padding: EdgeInsets.only(left: 32, top: 48,right: 32, bottom: 18),
    //             onPressed: (){
    //               Navigator.pop(context);
    //             },
    //             icon: Icon(
    //               Icons.arrow_back,
    //               size: 36,
    //               color: Colors.grey.withOpacity(0.8),
    //             )
    //         ),
    //         Container(
    //           child:TabBar(
    //             controller: _tabController,
    //             labelColor: Colors.black,
    //             unselectedLabelColor: Colors.red,
    //             indicatorColor: Colors.blue.withOpacity(0.6), // Đổi màu thanh trượt ở đây
    //             tabs: [
    //               Tab(
    //                 child: Text(
    //                   'Bài hát',
    //                   style: TextStyle(
    //                       fontSize: 20.0,
    //                       color: current_index == 0 ? Colors.black : Colors.grey,
    //                       fontWeight: FontWeight.bold,
    //                   ), // Điều chỉnh kích thước văn bản ở đây
    //                 ),
    //               ),
    //               Tab(
    //                 child: Text(
    //                   'Playlist',
    //                   style: TextStyle(
    //                     fontSize: 20.0,
    //                     color: current_index == 1 ? Colors.black : Colors.grey,
    //                     fontWeight: FontWeight.bold,
    //                   ), // Điều chỉnh kích thước văn bản ở đây
    //                 ),
    //               ),
    //               Tab(
    //                 child: Text(
    //                   'Nghệ sĩ',
    //                   style: TextStyle(
    //                     fontSize: 20.0,
    //                     color: current_index == 2 ? Colors.black : Colors.grey,
    //                     fontWeight: FontWeight.bold,
    //                   ), // Điều chỉnh kích thước văn bản ở đây
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           child: TabBarView(
    //             controller: _tabController,
    //             children: [
    //               SingleChildScrollView(
    //                 padding: EdgeInsets.only(left: 32),
    //                 child: Column(
    //                   children: List.generate(
    //                     20,
    //                         (index) => Column(
    //                           children: [
    //                             SizedBox(height: 8,),
    //                             Container(
    //                             child: Row(
    //                               children: [
    //                                 Container(
    //                                   width: 60,
    //                                   height: 60,
    //                                   decoration: BoxDecoration(
    //                                     image: DecorationImage(
    //                                       image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                     borderRadius: BorderRadius.circular(8),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 12,),
    //                                 Column(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       'Trời giấu trời mang đi',
    //                                       style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 17,
    //                                         fontWeight: FontWeight.bold,
    //                                         letterSpacing: 0.6,
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       'Amee - Viruss',
    //                                       style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 15,
    //                                         fontWeight: FontWeight.normal,
    //                                         letterSpacing: 0.4,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(width: 12,),
    //                                 IconButton(
    //                                   onPressed: (){},
    //                                   icon: Icon(
    //                                     Icons.play_arrow,
    //                                     size: 36,
    //                                     color: Colors.grey.withOpacity(0.8),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 0,),
    //                                 IconButton(
    //                                   onPressed: (){},
    //                                   icon: Icon(
    //                                     Icons.more_vert,
    //                                     size: 36,
    //                                     color: Colors.grey.withOpacity(0.8),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                             SizedBox(height: 16,)
    //                           ]
    //                         ),
    //                   ),
    //                 ),
    //               ),
    //               SingleChildScrollView(
    //                 padding: EdgeInsets.only(left: 32),
    //                 child: Column(
    //                   children: List.generate(
    //                     20,
    //                         (index) => Column(
    //                         children: [
    //                           SizedBox(height: 8,),
    //                           Container(
    //                             child: Row(
    //                               children: [
    //                                 Container(
    //                                   width: 60,
    //                                   height: 60,
    //                                   decoration: BoxDecoration(
    //                                     image: DecorationImage(
    //                                       image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                     borderRadius: BorderRadius.circular(8),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 12,),
    //                                 Column(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       'Trời giấu trời mang đi',
    //                                       style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 17,
    //                                         fontWeight: FontWeight.bold,
    //                                         letterSpacing: 0.6,
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       'Amee - Viruss',
    //                                       style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 15,
    //                                         fontWeight: FontWeight.normal,
    //                                         letterSpacing: 0.4,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(width: 12,),
    //                                 IconButton(
    //                                   onPressed: (){},
    //                                   icon: Icon(
    //                                     Icons.play_arrow,
    //                                     size: 36,
    //                                     color: Colors.grey.withOpacity(0.8),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 0,),
    //                                 IconButton(
    //                                   onPressed: (){},
    //                                   icon: Icon(
    //                                     Icons.more_vert,
    //                                     size: 36,
    //                                     color: Colors.grey.withOpacity(0.8),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(height: 16,)
    //                         ]
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SingleChildScrollView(
    //                 padding: EdgeInsets.only(left: 32),
    //                 child: Column(
    //                   children: List.generate(
    //                     20,
    //                         (index) => Column(
    //                         children: [
    //                           SizedBox(height: 8,),
    //                           Container(
    //                             child: Row(
    //                               children: [
    //                                 Container(
    //                                   width: 60,
    //                                   height: 60,
    //                                   decoration: BoxDecoration(
    //                                     image: DecorationImage(
    //                                       image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                     borderRadius: BorderRadius.circular(8),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 12,),
    //                                 Column(
    //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                   crossAxisAlignment: CrossAxisAlignment.start,
    //                                   children: [
    //                                     Text(
    //                                       'Trời giấu trời mang đi',
    //                                       style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 17,
    //                                         fontWeight: FontWeight.bold,
    //                                         letterSpacing: 0.6,
    //                                       ),
    //                                     ),
    //                                     Text(
    //                                       'Amee - Viruss',
    //                                       style: TextStyle(
    //                                         color: Colors.black,
    //                                         fontSize: 15,
    //                                         fontWeight: FontWeight.normal,
    //                                         letterSpacing: 0.4,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 SizedBox(width: 12,),
    //                                 IconButton(
    //                                   onPressed: (){},
    //                                   icon: Icon(
    //                                     Icons.play_arrow,
    //                                     size: 36,
    //                                     color: Colors.grey.withOpacity(0.8),
    //                                   ),
    //                                 ),
    //                                 SizedBox(width: 0,),
    //                                 IconButton(
    //                                   onPressed: (){},
    //                                   icon: Icon(
    //                                     Icons.more_vert,
    //                                     size: 36,
    //                                     color: Colors.grey.withOpacity(0.8),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           SizedBox(height: 16,)
    //                         ]
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IconButton(
            //     padding: EdgeInsets.only(left: 32, top: 48,right: 32, bottom: 18),
            //     onPressed: (){
            //       Navigator.pop(context);
            //     },
            //     icon: Icon(
            //       Icons.arrow_back,
            //       size: 36,
            //       color: Colors.grey.withOpacity(0.8),
            //     )
            // ),
            Container(
              child:TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.red,
                indicatorColor: Colors.blue.withOpacity(0.6), // Đổi màu thanh trượt ở đây
                tabs: [
                  Tab(
                    child: Text(
                      'Bài hát',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: current_index == 0 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ), // Điều chỉnh kích thước văn bản ở đây
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Playlist',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: current_index == 1 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ), // Điều chỉnh kích thước văn bản ở đây
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Nghệ sĩ',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: current_index == 2 ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ), // Điều chỉnh kích thước văn bản ở đây
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      children: List.generate(
                        20,
                            (index) => Column(
                            children: [
                              SizedBox(height: 8,),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Trời giấu trời mang đi',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                        Text(
                                          'Amee - Viruss',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12,),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.play_arrow,
                                        size: 36,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                    SizedBox(width: 0,),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 36,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16,)
                            ]
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      children: List.generate(
                        20,
                            (index) => Column(
                            children: [
                              SizedBox(height: 8,),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Trời giấu trời mang đi',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                        Text(
                                          'Amee - Viruss',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12,),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.play_arrow,
                                        size: 36,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                    SizedBox(width: 0,),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 36,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16,)
                            ]
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      children: List.generate(
                        20,
                            (index) => Column(
                            children: [
                              SizedBox(height: 8,),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/des/troi_giau_troi_mang_di.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SizedBox(width: 12,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Trời giấu trời mang đi',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                          ),
                                        ),
                                        Text(
                                          'Amee - Viruss',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 12,),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.play_arrow,
                                        size: 36,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                    SizedBox(width: 0,),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 36,
                                        color: Colors.grey.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16,)
                            ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
