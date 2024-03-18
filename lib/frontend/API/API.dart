import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Common/Song.dart';
import '../Common/Playlist.dart';
import '../Common/Artist.dart';

class API {
  Future<List<Song>> fetchTop10Songs() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getTop10Song'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<Playlist>> fetchPlaylists(userId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getPlaylistCreated?userId=$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Playlist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }

  Future<void> createNewPlayList(input) async {
    final url = Uri.parse('http://10.0.2.2:8090/createNewPlayListByUser?userId=1&name=$input');
    final response = await http.post(
      url,
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  }

  Future<List<Song>> fetchSongFromPlaylist(playlistId) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8090/getSongFromPlaylist?playlistId=$playlistId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<Song>> searchSongs(searchInput) async {
    String url = "http://10.0.2.2:8090/searchSong?searchInput=$searchInput";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchSong?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Song.fromJson(json)).toList();
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<Playlist>> searchPlaylists(searchInput) async {
    String url = "http://10.0.2.2:8090/searchPlayList?searchInput=$searchInput";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchPlayList?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Playlist.fromJson(json)).toList();
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<Artist>> searchArtists(searchInput) async {
    String url = "http://10.0.2.2:8090/searchArtist?searchInput=$searchInput";
    // final response = await http.get(Uri.parse('http://10.0.2.2:8090/searchPlayList?searchInput=$searchInput'));
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Artist.fromJson(json)).toList();
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<void> addNewSongToPlaylist(playlistId,songId) async {
    final url = Uri.parse('http://10.0.2.2:8090/addNewSongToPlayList?playlistId=$playlistId&songId=$songId');
    final response = await http.post(
      url,
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  }

  Future<List<int>> getSongAdded(playlistId) async {
    String url = "http://10.0.2.2:8090/getSongAdded?playlistId=$playlistId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<int> songIds = data.map((json) => int.tryParse(json) ?? 0).toList();
      return songIds;
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<int>> getSongAddedFavourite(userId) async {
    String url = "http://10.0.2.2:8090/getSongAddedFavourite?userId=$userId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<int> songIds = data.map((json) => int.tryParse(json) ?? 0).toList();
      return songIds;
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<int>> getPlayListAddedFavourite(userId) async {
    String url = "http://10.0.2.2:8090/getPlayListFavouriteAdded?userId=$userId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<int> songIds = data.map((json) => json as int).toList();
      return songIds;
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<List<int>> getArtistAddedFavourite(userId) async {
    String url = "http://10.0.2.2:8090/getArtistFavouriteAdded?userId=$userId";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<int> songIds = data.map((json) => int.tryParse(json) ?? 0).toList();
      return songIds;
    } else {
      print("day la url  ----------   " + url);
      throw Exception('Failed to fetch songs');
    }
  }

  Future<void> addSongFavourite(songId,userId) async {
    String url = "http://10.0.2.2:8090/addSongFavourite?songId=$songId&userId=$userId";
    final respone = await http.post(Uri.parse(url));
    if(respone.statusCode == 200)
      {
        print(respone.body);
      }
    else
    {
      print("day la url  ----------   " + url);
      throw Exception('Failed to add new song to favourite');
    }
  }

  Future<void> addPlayListFavorite(playlistId,userId) async{
    String url = "http://10.0.2.2:8090/addPlayListFavorite?playlistId=$playlistId&userId=$userId";
    final respone = await http.post(Uri.parse(url));
    if(respone.statusCode == 200)
    {
      print(respone.body);
    }
    else
    {
      print("day la url  ----------   " + url);
      throw Exception('Failed to add new song to favourite');
    }
  }

  Future<void> addArtistFavorite(artistId,userId) async{
    String url = "http://10.0.2.2:8090/addArtistFavorite?artistId=$artistId&userId=$userId";
    final respone = await http.post(Uri.parse(url));
    if(respone.statusCode == 200)
    {
      print(respone.body);
    }
    else
    {
      print("day la url  ----------   " + url);
      throw Exception('Failed to add new song to favourite');
    }
  }

  Future<dynamic> createNewUser(name, password) async{
    String url = "http://10.0.2.2:8090/CreateNewUser1";
    final Map<String, String> data = {
      'name': name,
      'password': password,
    };
    final response = await http.post(Uri.parse(url),body: jsonEncode(data),headers: <String, String>{
      'Content-Type': 'application/json', // Đặt header 'Content-Type' là 'application/json'
    },);
    if (response.statusCode == 200) {
      // Xử lý phản hồi ở đây nếu cần
      return response.body;
    } else {
      // Xử lý lỗi nếu có
      return response.body;
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<dynamic> login(name, password) async{
    String url = "http://10.0.2.2:8090/login?name=$name&password=$password";
    final response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future<void> removeSongFromPlayList(id) async{
    String url = "http://10.0.2.2:8090/removeSongFromPlayList?id=$id";
    final respone = await http.delete(Uri.parse(url));
  }

  Future<void> removeSongFromFavourite(id) async{
    String url = "http://10.0.2.2:8090/removeSongFromSongFavoritesList?id=$id";
    final respone = await http.delete(Uri.parse(url));
  }

  Future<void> removePlayListFavourite(id) async{
    String url = "http://10.0.2.2:8090/removePlayListFavourite?id=$id";
    final respone = await http.delete(Uri.parse(url));
  }

  Future<void> removeArtistFavourite(id) async{
    String url = "http://10.0.2.2:8090/removeArtistFavourite?id=$id";
    final respone = await http.delete(Uri.parse(url));
  }

  Future<void> removePlaylistCreated(id) async{
    String url = "http://10.0.2.2:8090/removePlaylistCreated?id=$id";
    final respone = await http.delete(Uri.parse(url));
  }

}