import 'dart:async';
import 'dart:math';

import 'package:audioplayers_platform_interface/src/api/player_state.dart';
import 'package:flutter/material.dart';
import 'package:radio/frontend/API/API.dart';
import 'package:radio/frontend/Common/Song.dart';
import 'package:radio/frontend/MusicPlayer/MusicPlayer.dart';
import 'package:radio/frontend/User/UserSession.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


late final GlobalKey<_SpinCircleAvatarState> _spinCircleAvatarKey = GlobalKey<_SpinCircleAvatarState>();

class MusicPlayerDisplay extends StatefulWidget {
  const MusicPlayerDisplay({super.key});
  @override
  State<MusicPlayerDisplay> createState() => _MusicPlayerDisplayState();
}

class _MusicPlayerDisplayState extends State<MusicPlayerDisplay> {
  API api = API();
  double _currentSliderValue = 0;
  bool musicPlaying = true;
  String curName = '';
  String curAuthor = '';
  int curIndex = 0;
  String curImgPath ='';
  String curMusicPath = '';
  int curSongId = 0;
  Duration duration = Duration.zero;
  int totalOfAudio = 0;
  Duration position = Duration.zero;
  double _progress = 0;
  List<Song> listSongs = [];
  bool initData = false;
  bool replay = false;
  SpinCircleAvatar? spinner;
  MusicPlayer musicPlayer = MusicPlayer();
  List<int> songFavourites = [];

  fetchDataAndPlayMusic(data) async {
    // Your asynchronous logic to fetch data
    // Assuming data is fetched from somewhere asynchronously and stored in 'data'
    // Update the state using setState
    setState(() {
      curName = data['name'];
      curAuthor = data['author'];
      curIndex = data['index'];
      curSongId = data['songId'];
      curImgPath = data['imgUrl'];
      curMusicPath = data['musicUrl'];
      initData = true;
      listSongs = data['listSong'];
      spinner = SpinCircleAvatar(key: _spinCircleAvatarKey, curImgUrl: curImgPath);
      print('$curIndex - $curName - $curAuthor - $curImgPath - $curMusicPath');
    });
    // Now, you can use await to ensure musicplayer.play is completed before proceeding
    await musicPlayer.play(curMusicPath);
    var respone =await api.getSongAddedFavourite(UserSession().getUserId());
    setState(() {
      songFavourites = respone;
      for(int id in songFavourites)
        {
          print(id);
        }
    });
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
      musicPlayer.getAudioPlayer()?.onDurationChanged.listen((event) {
        if(mounted) {
          setState(() {
            if(event.inSeconds!=0)
              duration = event;
            totalOfAudio = duration.inSeconds;
          });
        }
      });
      musicPlayer.getAudioPlayer()?.onPositionChanged.listen((event) {
        if(mounted) {
          setState(() {
            position = event;
            if (duration?.inSeconds != 0) {
              _progress = position.inSeconds * 1.0 / (duration!.inSeconds * 2);
              _currentSliderValue =
                  min(position.inSeconds * 100.0 / (duration!.inSeconds),100);
            }
          });
        }
      });

      // while(totalOfAudio == 0)
      // {
      //   duration = MusicPlayer.getInstance().getAudioPlayer()?.getDuration() as Duration?;
      //
      // }

      musicPlayer.getAudioPlayer()?.onPlayerStateChanged.listen((event) async {
        if(mounted){
        if (event != null && event is PlayerState) {
            switch (event) {
              case PlayerState.stopped:
                setState(() {
                  musicPlaying = false;
                  spinner?.pauseAnimation();
                });
                break;
              case PlayerState.playing:
                {
                  setState(() {
                    musicPlaying = true;
                    spinner?.resumeAnimation();
                  });
                  spinner?.resumeAnimation();
                  break;
                }
              case PlayerState.paused:
                {
                  setState((){
                    musicPlaying = false;
                    spinner?.pauseAnimation();
                  });
                  break;
                }
              case PlayerState.completed:
                {
                  setState((){
                    musicPlaying = false;
                    spinner?.pauseAnimation();
                  });
                  break;
                }
              default:
                break;
            }
          }
        }
      });

      musicPlayer.getAudioPlayer()?.onPlayerComplete.listen((event) async{
        await musicPlayer.stopAudio();
        spinner?.setValueAnimation(0);
        // await MusicPlayer.getInstance().pause();
        // await MusicPlayer.getInstance().seekAudio(0);
        // await MusicPlayer.getInstance().resume(curMusicPath);
        // await MusicPlayer.getInstance().pause();
        await musicPlayer.play(curMusicPath);
        print("day la music url hien tai" + curMusicPath);
        if(!replay)
        {
          await musicPlayer.pause();
          setState(() {
            position = Duration.zero;
            _currentSliderValue = 0;
            _progress = 0;
          });
          // playNextAudio();
        }
        // await MusicPlayer.getInstance().replayAudio(curMusicPath);
      });
  }

  void playNextAudio() async
  {
    int n = listSongs.length;
    int newIndex = (curIndex+1) % n;
    print(listSongs);
    print('prevIndex: $curIndex - newIndex: $curIndex');
    setState(() {
      curName = listSongs[newIndex].songName!;
      curIndex = newIndex;
      curSongId = listSongs[newIndex].songId;
      curImgPath = listSongs[newIndex].songImage!;
      curMusicPath = listSongs[newIndex].songUrl!;
      curAuthor = listSongs[newIndex].songAuthor;
      spinner?.setImg(curImgPath);
      _progress=0;
    });
    // await musicPlayer.deposeAudio();
    await musicPlayer.play(curMusicPath);
  }

  void playPreviousAuido() async
  {
    int n = listSongs.length;
    int newIndex = (curIndex + n - 1) % n;
    setState(() {
      curName = listSongs[newIndex].songName;
      curAuthor = listSongs[newIndex].songAuthor;
      curIndex = newIndex;
      curSongId = listSongs[newIndex].songId;
      curImgPath = listSongs[newIndex].songImage;
      curMusicPath = listSongs[newIndex].songUrl;
      spinner?.setImg(curImgPath);
      _progress=0;
    });
    // await musicPlayer.deposeAudio();
    await musicPlayer.play(curMusicPath);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    musicPlayer.getAudioPlayer()?.dispose();
    // MusicPlayer.getInstance().getAudioPlayer()?.stop();
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (!initData){
      // setState(() {
      //   curName = data['name'];
      //   curAuthor = data['author'];
      //   curIndex = data['index'];
      //   curImgPath = data['imgUrl'];
      //   curMusicPath = data['musicUrl'];
      //   initData = true;
      //   listSongs = data['listSong'];
      //   spinner = SpinCircleAvatar(key: _spinCircleAvatarKey,curImgUrl: curImgPath,);
      //   print('$curIndex - $curName - $curAuthor - $curImgPath - $curMusicPath');
      // });
      fetchDataAndPlayMusic(data);
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          padding: EdgeInsets.fromLTRB(32, 96, 28, 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                '$curName',
                colors: [Color(0xFF000000).withOpacity(0.75), Color(0xFF002369).withOpacity(0.75)],
                style: TextStyle(
                  fontSize: 28,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1, // Giới hạn số dòng là 2
                overflow: TextOverflow.ellipsis, // Hiển thị dấu "..." nếu nội dung vượt quá
              ),
              SizedBox(height: 12,),
              GradientText(
                '$curAuthor',
                colors: [Color(0xFF000000).withOpacity(0.6), Color(0xFF002369).withOpacity(0.6)],
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1, // Giới hạn số dòng là 2
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'NTM RADIO PRO',
                style: TextStyle(
                  color: Color(0xFF70ACD3),
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 32,),
              Container(
              constraints: BoxConstraints(
                minHeight: 480,
                minWidth: 68,
              ),
              margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(12, 32, 12, 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB0D5EA), Color(0xFFC6E1F0)],
                ),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF7EB1CC),
                    blurRadius: 21,
                    offset: Offset(6,4),
                  ),
                  BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 64,
                    offset: Offset(-10,18),
                  ),
                  BoxShadow(
                    color: Color(0xFFFFFFFF),
                    blurRadius: 12,
                    offset: Offset(0,0),
                  ),
                  BoxShadow(
                    color: Color(0xFF9DC9E4),
                    blurRadius: 19,
                    offset: Offset(13,-14),
                  ),
                  BoxShadow(
                    color: Color(0xFFDDEEF6),
                    blurRadius: 39,
                    offset: Offset(-19,-27),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 4,
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: GradientIcon(
                      icon: Icons.replay,
                      gradient: LinearGradient(
                        // colors: [Color(0xFF77B0D4),Color(0xFFA1CCE4)],
                        colors: [Color(0xFF77B0D4),Color(0xFF9ECAE3)],
                      ),
                      size: 42,
                    ),
                    onTap: (){
                      musicPlayer.replayAudio(curMusicPath);
                    },
                  ),
                  InkWell(
                    child: GradientIcon(
                      icon: Icons.skip_next,
                      gradient: LinearGradient(
                        // colors: [Color(0xFF77B0D4),Color(0xFFA1CCE4)],
                        colors: [Color(0xFF77B0D4),Color(0xFF9ECAE3)],
                      ),
                      size: 42,
                    ),
                    onTap: (){
                      playNextAudio();
                    },
                  ),
                  musicPlaying == false ? InkWell(
                    onTap: (){
                      // setState(() {
                      //   musicPlaying=!musicPlaying;
                      // });
                      musicPlayer.resume(curMusicPath);
                    },
                    child: GradientIcon(
                      icon: Icons.play_arrow,
                      gradient: LinearGradient(
                        // colors: [Color(0xFF77B0D4),Color(0xFFA1CCE4)],
                        colors: [Color(0xFF77B0D4),Color(0xFF9ECAE3)],
                      ),
                      size: 42,
                    ),
                  ) : InkWell(
                    onTap: (){
                      // setState(() {
                      //   musicPlaying=!musicPlaying;
                      // });
                      musicPlayer.pause();
                    },
                    child: GradientIcon(
                      icon: Icons.pause,
                      gradient: LinearGradient(
                        // colors: [Color(0xFF77B0D4),Color(0xFFA1CCE4)],
                        colors: [Color(0xFF77B0D4),Color(0xFF9ECAE3)],
                      ),
                      size: 42,
                    ),
                  ),
                  InkWell(
                    child: GradientIcon(
                      icon: Icons.skip_previous,
                      gradient: LinearGradient(
                        // colors: [Color(0xFF77B0D4),Color(0xFFA1CCE4)],
                        colors: [Color(0xFF77B0D4),Color(0xFF9ECAE3)],
                      ),
                      size: 42,
                    ),
                    onTap: (){
                      playPreviousAuido();
                    },
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        replay = !replay;
                      });
                    },
                    child: GradientIcon(
                      icon: Icons.settings_backup_restore,
                      gradient: LinearGradient(
                        // colors: [Color(0xFF77B0D4),Color(0xFFA1CCE4)],
                        colors: !replay ? [Color(0xFF77B0D4).withOpacity(0.3),Color(0xFF9ECAE3).withOpacity(0.3)] : [Color(0xFF77B0D4).withOpacity(0.8),Color(0xFF9ECAE3).withOpacity(0.8)],
                      ),
                      size: 42,
                    ),
                  ),
                  InkWell(
                    child: !songFavourites.contains(curSongId) ? IconButton(
                      icon: Icon(Icons.favorite_border,
                        color: Colors.purpleAccent.withOpacity(0.9),
                        size: 28,),
                      onPressed: ()async{
                        await api.addSongFavourite(curSongId, UserSession().getUserId());
                        var data = await api.getSongAddedFavourite(UserSession().getUserId());
                        setState(() {
                          songFavourites = data;
                        });
                      },
                    ) : Icon(
                      Icons.favorite,
                      color: Colors.purpleAccent.withOpacity(0.9),
                      size: 28,
                    ),
                  )
                ],
              ),
                            ),
              SizedBox(height: 32,),
              Container(
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 3.7, // Height of the slider track
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 8.0,
                          disabledThumbRadius:10,// Radius of the enabled thumb
                        ),
                        overlayColor: Colors.red.withOpacity(0.3), // Color of the overlay when pressed
                        activeTrackColor: Colors.white, // Color of the active portion of the track
                        inactiveTrackColor: Colors.white.withOpacity(0.8),
                      ),
                      child: Slider(
                        value: _currentSliderValue,
                        max: 100,
                        activeColor: Color(0xFF00B2FF),
                        inactiveColor: Color(0xFF8D8E98),
                        onChanged: (double value){
                          setState(() {
                            _currentSliderValue = value;
                            _progress = value / 200.0;
                            musicPlayer.seekAudio((value * totalOfAudio / 100.0).toInt());
                          });
                        },
                        onChangeEnd: (double value){
                          if(value!=100)
                            musicPlayer.resume(curMusicPath);
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GradientText(
                          '${formatDuration(position)}',
                          colors: [Color(0xFF000000).withOpacity(0.6), Color(0xFF002369).withOpacity(0.6)],
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GradientText(
                          '${formatDuration(duration!)}',
                          colors: [Color(0xFF000000).withOpacity(0.6), Color(0xFF002369).withOpacity(0.6)],
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
          ],
        )
        ,
        ),
          Positioned(
              top: MediaQuery.of(context).size.height/2 - 240,
              left: 160,
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 500,
                  minHeight: 500,
                ),
                padding: EdgeInsets.all(64),
                decoration: BoxDecoration(
                  color: Color(0xFFB1D6EA),
                  borderRadius: BorderRadius.circular(300),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 5,
                  )
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 400,
                    maxWidth: 400,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red.withOpacity(1),
                    //   width: 4,
                    // ),
                    borderRadius: BorderRadius.circular(180),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 100,
                        offset: Offset(0,0),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 70,
                        offset: Offset(-24,-9),
                      ),
                      BoxShadow(
                        color: Color(0xFF3D799F).withOpacity(0.6),
                        blurRadius: 48,
                        offset: Offset(12,41),
                      )
                    ]
                  ),
                  // padding: EdgeInsets.all(28),
                  child: CustomPaint(
                    painter: CirclePainter(_progress),
                    child: spinner,
                    //child: SpinCircleAvatar(curImgPath),
                    // child: CircleAvatar(
                    //   backgroundImage: AssetImage(curImgPath),
                    // ),
                  ),
                ),
              )
          ),
          Positioned(
            top: 40,
            left: 24,
            child: IconButton(
              onPressed: (){
                musicPlayer.stopAudio();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
        ]
      ),
    );
  }

  String formatDuration(Duration duration) {
    // Lấy giờ, phút và giây từ đối tượng Duration
    int hours = duration.inHours;
    int minutes = (duration.inMinutes % 60);
    int seconds = (duration.inSeconds % 60);

    // Định dạng thành chuỗi "hh:mm:ss"
    String formattedDuration = '${hours !=0 ? '${hours.toString()}:' : ''}${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return formattedDuration;
  }
}

class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [Color(0xFFB30000).withOpacity(0.6), Color(0xFFFF0000).withOpacity(0.6)], // Màu sắc gradient
        stops: [0.0, 1.0],
        radius: 0.8,
      ).createShader(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2))
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    double radius = 200;
    double arcAngle = 2 * pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
      -pi / 2,
      -arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SpinCircleAvatar extends StatefulWidget {
  final String curImgUrl;

  SpinCircleAvatar({Key? key, required this.curImgUrl}) : super(key: key);

  void setImg(String url) {
    _spinCircleAvatarKey.currentState?.updateState(url);
  }

  void pauseAnimation()
  {
    _spinCircleAvatarKey.currentState?.pauseAnimation();
  }

  void resumeAnimation()
  {
    _spinCircleAvatarKey.currentState?.resumeAnimation();
  }

  void setValueAnimation(double val)
  {
    _spinCircleAvatarKey.currentState?.setValueAnimation(val);
  }

  @override
  _SpinCircleAvatarState createState() => _SpinCircleAvatarState(curImgUrl);
}

class _SpinCircleAvatarState extends State<SpinCircleAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  String curImgUrl = '';

  _SpinCircleAvatarState(this.curImgUrl);
  void updateState(String newUrl) {
    setState(() {
      curImgUrl = newUrl;
      // Thực hiện các tác vụ cần thiết khi curImgUrl thay đổi
      print("New Image URL: $newUrl");
    });
  }

  void setValueAnimation(double val)
  {
    setState(() {
      _controller.value = val;
    });
  }

  void pauseAnimation()
  {
    if(!_controller.isDismissed) _controller.stop();
  }

  void resumeAnimation(){
    if(!_controller.isAnimating) _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 100),
    )..repeat(); // Lặp lại animation
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
      child: CircleAvatar(
        backgroundImage: Image.network(curImgUrl).image,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
