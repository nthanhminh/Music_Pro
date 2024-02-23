import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:radio/frontend/MusicPlayer/MusicPlayer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SongRender extends StatefulWidget {
  int index=0;
  String name='';
  String author='';
  String imgUrl='';
  String musicUrl='';
  List<Map<String,dynamic>> data = [];
  SongRender(this.index, this.name, this.author, this.imgUrl,this.musicUrl,this.data);

  @override
  State<SongRender> createState() => _SongRenderState();
}

class _SongRenderState extends State<SongRender> {
  @override
  Widget build(BuildContext context) {
    Duration duration = Duration.zero;
    Duration position = Duration.zero;
    return TextButton(
      onPressed: () async {
        MusicPlayer.getInstance().play(widget.musicUrl);
        Navigator.pushNamed(context, '/MusicDisplay', arguments: {
          'index': widget.index,
          'name' : widget.name,
          'author': widget.author,
          'imgUrl': widget.imgUrl,
          'musicUrl' : widget.musicUrl,
          'listSong' : widget.data,
        });
        MusicPlayer.getInstance().getAudioPlayer()?.onDurationChanged.listen((event) {
          setState(() {
            duration = event;
          });
        });
        MusicPlayer.getInstance().getAudioPlayer()?.onPositionChanged.listen((event) {
          setState(() {
            position = event;
          });
        });

      },
      child: Container(
        padding: EdgeInsets.fromLTRB(18, 6, 36, 6),
        margin: EdgeInsets.only(bottom: 32),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 64,
          minHeight: 60,
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB0D5EA), Color(0xFFC6E1F0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 3,
              style: BorderStyle.solid,
              strokeAlign: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF7EB3CD).withOpacity(0.6),
                blurRadius: 16,
                offset: Offset(5, 11),
              ),
              BoxShadow(
                color: Color(0xFFFFFFFF).withOpacity(0.6),
                blurRadius: 64,
                offset: Offset(-10, 18),
              ),
              BoxShadow(
                color: Color(0xFFFFFFFF).withOpacity(0.6),
                blurRadius: 12,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Color(0xFF9DC9E4).withOpacity(0.6),
                blurRadius: 12,
                offset: Offset(13, 13),
              ),
              BoxShadow(
                color: Color(0xFFDDEEF6).withOpacity(0.6),
                blurRadius: 39,
                offset: Offset(-19, -27),
              ),
            ]),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('${widget.imgUrl}'),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GradientText(
                        '${widget.index}',
                        colors: [Colors.red, Colors.yellow],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.name}',
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1.2,
                            color: Color(0xFF2368A4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.music_note,
                        color: Colors.green.withOpacity(0.6),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.author}',
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            letterSpacing: 1.2,
                            color: Color(0xFF2368A4),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // Container(
            //   constraints: BoxConstraints(
            //     maxWidth: 24,
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Color(0xFF9ECCE4), Color(0xFFD1E8F4)],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       stops: [0.0, 1.0],
            //       tileMode: TileMode.clamp,
            //     ),
            //     borderRadius: BorderRadius.circular(16.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.white.withOpacity(0.5),
            //         spreadRadius: 2,
            //         blurRadius: 3,
            //         offset: Offset(0, 1), // Điều chỉnh vị trí của bóng
            //       ),
            //     ],
            //   ),
            //   child: TextButton(
            //     onPressed: () => {},
            //     child: Column(
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: Color(0xFFF0F8FA),
            //           radius: 2,
            //         ),
            //         // SizedBox(height: 2,),
            //         CircleAvatar(
            //           backgroundColor: Color(0xFFF0F8FA),
            //           radius: 2,
            //         ),
            //         // SizedBox(height: 2,),
            //         CircleAvatar(
            //           backgroundColor: Color(0xFFF0F8FA),
            //           radius: 2,
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

String formatDuration(Duration? duration) {
  // Chuyển đổi Duration thành chuỗi hh:mm:ss
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration!.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration!.inSeconds.remainder(60));
  return "${twoDigits(duration!.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

int getTime(Duration? duration)
{
  // String twoDigits(int n) => n.toString().padLeft(2, '0');
  // String twoDigitMinutes = twoDigits(duration!.inMinutes.remainder(60));
  // String twoDigitSeconds = twoDigits(duration!.inSeconds.remainder(60));
  int res = 0;
  int h = duration!.inHours;
  int p = duration!.inMinutes;
  int s = duration!.inSeconds;
  print('Hours: $h - Minutes: $p - Second: $s');
  res = h*3600+p*60+s;
  return res;
}