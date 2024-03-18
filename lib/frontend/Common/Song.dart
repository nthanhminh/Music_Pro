class Song {
  final int songId;
  final String songName;
  final String songAuthor;
  final String songImage;
  final String songUrl;
  final int removeId;
  const Song({
    required this.songId,
    required this.songName,
    required this.songAuthor,
    required this.songImage,
    required this.songUrl,
    required this.removeId
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    final dynamic removeId = json['removeId'];
    final int removeIdValue = (removeId != null) ? removeId as int : -1;
    return Song(
      songId: int.tryParse(json['id'].toString()) ?? 0,
      songName: json['name'] as String,
      songAuthor: json['author'] as String,
      songImage: json['imgUrl'] as String,
      songUrl: json['musicUrl'] as String,
      removeId: removeIdValue
    );
  }
}
