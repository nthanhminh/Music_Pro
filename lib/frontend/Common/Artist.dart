class Artist {
  final int artistId;
  final String artistName;
  final String artistImage;
  final int removeId;

  const Artist({
    required this.artistId,
    required this.artistName,
    required this.artistImage,
    required this.removeId
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    final dynamic removeId = json['removeId'];
    final int removeIdValue = (removeId != null) ? removeId as int : -1;
    return Artist(
      artistId: json['id'] as int,
      artistName: json['name'] as String,
      artistImage: json['imgUrl'] as String,
      removeId: removeIdValue
    );
  }
}
