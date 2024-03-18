import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/frontend/API/API.dart';
import 'package:radio/frontend/Common/Artist.dart';
import 'package:radio/frontend/Common/Playlist.dart';
import 'package:radio/frontend/PlayList/PlayList.dart';
import 'package:radio/frontend/User/UserSession.dart';

import '../Common/Song.dart';

class SearchResult extends StatefulWidget {
  List<Song> songs = [];
  List<Playlist> playlists = [];
  List<Artist> artists = [];
  SearchResult(this.songs,this.playlists,this.artists);
  SearchResult.none();

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> with SingleTickerProviderStateMixin {
  List<int> songFavourites = [];
  List<int> playlistFavourites = [];
  List<int> artistFavourites = [];
  API api = API();
  int current_index = 0;
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener((){
      print(_tabController.index);
      setState(() {
        current_index = _tabController.index;
      });
    });
    api.getSongAddedFavourite(UserSession().getUserId()).then((data){
      setState(() {
        songFavourites = data;
      });
    });

    api.getPlayListAddedFavourite(UserSession().getUserId()).then((data){
      setState(() {
        playlistFavourites = data;
      });
    });

    api.getArtistAddedFavourite(UserSession().getUserId()).then((data){
      setState(() {
        artistFavourites = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      children: [
                        SizedBox(height: 8,),
                        ...widget.songs.asMap().entries.map((e){
                            final song = e.value;
                            return Container(
                              margin: EdgeInsets.only(bottom: 32),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: Image.network(song.songImage).image,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(width: 12,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song.songName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.6,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          song.songAuthor,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 0.4,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
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
                                  songFavourites.contains(song.songId) ? IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 28,
                                      color: Colors.purpleAccent.withOpacity(0.6),
                                    ),
                                  ) : IconButton(
                                    onPressed: ()async{
                                        await api.addSongFavourite(song.songId, UserSession().getUserId());
                                        var data = await api.getSongAddedFavourite(UserSession().getUserId());
                                        setState(() {
                                          songFavourites = data;
                                        });
                                    },
                                    icon: Icon(
                                      Icons.favorite_border,
                                      size: 28,
                                      color: Colors.purpleAccent.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            );
                        }).toList(),
                        ]
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      children: [
                        ...widget.playlists.asMap().entries.map((e){
                          final song = e.value;
                          return Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.network(song.playlistImage).image,
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
                                      song.playlistName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
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
                                playlistFavourites.contains(song.playlistId) ? IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 28,
                                    color: Colors.purpleAccent.withOpacity(0.6),
                                  ),
                                ) : IconButton(
                                  onPressed: ()async{
                                    await api.addPlayListFavorite(song.playlistId, UserSession().getUserId());
                                    var data = await api.getPlayListAddedFavourite(UserSession().getUserId());
                                    setState(() {
                                      playlistFavourites = data;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: 28,
                                    color: Colors.purpleAccent.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      children: [
                        SizedBox(height: 8,),
                        ...widget.artists.asMap().entries.map((e){
                          final song = e.value;
                          return Container(
                            margin: EdgeInsets.only(bottom: 32),
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.network(song.artistImage).image,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        song.artistName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                artistFavourites.contains(song.artistId) ? IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 28,
                                    color: Colors.purpleAccent.withOpacity(0.6),
                                  ),
                                ) : IconButton(
                                  onPressed: ()async{
                                    await api.addArtistFavorite(song.artistId, UserSession().getUserId());
                                    var data = await api.getArtistAddedFavourite(UserSession().getUserId());
                                    setState(() {
                                      artistFavourites = data;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: 28,
                                    color: Colors.purpleAccent.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
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
