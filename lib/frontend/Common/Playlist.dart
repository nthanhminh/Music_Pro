class Playlist {
  final int playlistId;
  final String playlistName;
  final String playlistImage;

  const Playlist({
    required this.playlistId,
    required this.playlistName,
    required this.playlistImage,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      playlistId: json['id'] as int,
      playlistName: json['name'] as String,
      playlistImage: json['imgUrl'] as String,
    );
  }
}
