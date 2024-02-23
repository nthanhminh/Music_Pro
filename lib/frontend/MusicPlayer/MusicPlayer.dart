import 'package:audioplayers/audioplayers.dart';

class MusicPlayer {
  static MusicPlayer? _instance;
  AudioPlayer? _audioPlayer;
  bool playingMusic = false;

  MusicPlayer._() {
    _audioPlayer = AudioPlayer();
    _audioPlayer?.setPlayerMode(PlayerMode.mediaPlayer);
  }

  static MusicPlayer getInstance() {
    if (_instance == null) {
      _instance = MusicPlayer._();
    }
    return _instance!;
  }

  Future<void> play(String url) async {
    try {
      await _audioPlayer?.stop();
      await _audioPlayer?.play(AssetSource(url));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer?.pause();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resume(String url) async {
    try {
      print('${_audioPlayer?.state} in resume func');
      await _audioPlayer?.resume();
      print('${_audioPlayer?.state} in resume func');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> replayAudio(String url) async{
    await _audioPlayer?.stop();
    if(_audioPlayer?.state == PlayerState.stopped || _audioPlayer?.state == PlayerState.paused || _audioPlayer?.state == PlayerState.completed)
      {
        play(url);
      }
    await _audioPlayer?.seek(Duration.zero); // Đặt thời gian phát về 0
    _audioPlayer?.resume(); // Tiếp tục phát
  }

  Future<void> seekAudio(int s) async {
    try {
      await pause();
      print(_audioPlayer?.state);
      await _audioPlayer?.seek(Duration(seconds: s));
    } catch (e) {
      print("Error in seekAudio: $e");
    }
  }

  void stopAudio() async {
    await _audioPlayer?.pause();
  }

  AudioPlayer? getAudioPlayer(){
    return _audioPlayer;
  }
}
