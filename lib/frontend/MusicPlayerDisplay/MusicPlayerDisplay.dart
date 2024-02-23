import 'dart:async';
import 'dart:math';

import 'package:audioplayers_platform_interface/src/api/player_state.dart';
import 'package:flutter/material.dart';
import 'package:radio/frontend/MusicPlayer/MusicPlayer.dart';
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
  double _currentSliderValue = 0;
  bool musicPlaying = true;
  String curName = '';
  String curAuthor = '';
  int curIndex = 0;
  String curImgPath ='';
  String curMusicPath = '';
  Duration duration = Duration.zero;
  int totalOfAudio = 0;
  Duration position = Duration.zero;
  double _progress = 0;
  List<Map<String,dynamic>> listSongs = [];
  bool initData = false;
  bool replay = false;
  SpinCircleAvatar? spinner;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
      MusicPlayer.getInstance().getAudioPlayer()?.onDurationChanged.listen((event) {
        if(mounted) {
          setState(() {
            if(event.inSeconds!=0)
              duration = event;
            totalOfAudio = duration.inSeconds;
          });
        }
      });
      MusicPlayer.getInstance().getAudioPlayer()?.onPositionChanged.listen((event) {
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

      MusicPlayer.getInstance().getAudioPlayer()?.onPlayerStateChanged.listen((event) {
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
                  break;
                }
              case PlayerState.paused:
                {
                  setState(() {
                    musicPlaying = false;
                    spinner?.pauseAnimation();
                  });
                  break;
                }
              case PlayerState.completed:
                {
                  setState(() {
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

      MusicPlayer.getInstance().getAudioPlayer()?.onPlayerComplete.listen((event) async{
        await MusicPlayer.getInstance().getAudioPlayer()?.stop();
        await MusicPlayer.getInstance().play(curMusicPath);
        if(!replay)
        {
          await MusicPlayer.getInstance().pause();
          position = Duration.zero;
          _currentSliderValue = 0;
          _progress = 0;
        }
        spinner?.setValueAnimation(0);
        // await MusicPlayer.getInstance().replayAudio(curMusicPath);
      });
  }

  void playNextAudio()
  {
    int n = listSongs.length;
    int newIndex = (curIndex) % n;
    print(listSongs);
    print('prevIndex: $curIndex - newIndex: $newIndex');
    setState(() {
      curName = listSongs[newIndex]['name']!;
      curAuthor = listSongs[newIndex]['author']!;
      curIndex = listSongs[newIndex]['index']!;
      curImgPath = listSongs[newIndex]['imgUrl']!;
      curMusicPath = listSongs[newIndex]['songUrl']!;
      spinner?.setImg(curImgPath);
    });
    MusicPlayer.getInstance().play(curMusicPath);
  }

  void playPreviousAuido()
  {
    int n = listSongs.length;
    int newIndex = (curIndex + n - 2) % n;
    setState(() {
      curName = listSongs[newIndex]['name'];
      curAuthor = listSongs[newIndex]['author'];
      curIndex = listSongs[newIndex]['index'];
      curImgPath = listSongs[newIndex]['imgUrl'];
      curMusicPath = listSongs[newIndex]['songUrl'];
      spinner?.setImg(curImgPath);
    });
    MusicPlayer.getInstance().play(curMusicPath);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MusicPlayer.getInstance().getAudioPlayer()?.stop();
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (!initData) {
      setState(() {
        curName = data['name'];
        curAuthor = data['author'];
        curIndex = data['index'];
        curImgPath = data['imgUrl'];
        curMusicPath = data['musicUrl'];
        initData = true;
        listSongs = data['listSong'];
        spinner = SpinCircleAvatar(key: _spinCircleAvatarKey,curImgUrl: curImgPath,);
        print('$curIndex - $curName - $curAuthor - $curImgPath - $curMusicPath');
      });
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
                      MusicPlayer.getInstance().replayAudio(curMusicPath);
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
                      MusicPlayer.getInstance().resume(curMusicPath);
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
                      MusicPlayer.getInstance().pause();
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
                    onTap: playPreviousAuido,
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
                    child: Image(
                      image: AssetImage('assets/images/Vector.png'),
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
                            MusicPlayer.getInstance().seekAudio((value * totalOfAudio / 100.0).toInt());
                          });
                        },
                        onChangeEnd: (double value){
                          if(value!=100)
                            MusicPlayer.getInstance().resume(curMusicPath);
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
                MusicPlayer.getInstance().stopAudio();
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
        backgroundImage: AssetImage(curImgUrl),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
