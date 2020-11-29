import 'package:audioplayers/audioplayers.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf_flutter/pdf_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'dept_model.dart';

class FinalScreen extends StatefulWidget {
  final Topics data;

  const FinalScreen({Key key, this.data}) : super(key: key);

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final AudioPlayer audioPlayer = new AudioPlayer();
   Duration duration = new Duration();
  Duration position = new Duration();
  bool playing = false;

  String pdfUrl =
      'https://students.iusb.edu/academic-success-programs/academic-centers-for-excellence/docs/Basic%20Math%20Review%20Card.pdf';
  String youtubeURL = 'https://www.youtube.com/watch?v=6uBjMFoyT-I&t=601s';
  int currentIndex = 0;



  YoutubePlayerController _controller;

  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.data.youtubeLink));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List listOfBcColor = [
      Container(
        child: Scaffold(
          backgroundColor: Colors.grey[850],
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Center(
                child: PDF.network(
                  widget.data.pdfLink,
                  height: double.infinity,
                  width: double.infinity,
                )),
          ),
        ),
        alignment: Alignment.center,
      ),
      Container(
        child: Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                YoutubePlayer(
                  controller: _controller,
                ),
              ],
            ),
          ),
        ),
        color: Colors.grey[800],
        alignment: Alignment.center,
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset('images/audiologo.png'),
            slider(),
            InkWell(
              onTap: () {
                getAudio();
              },
              child: Icon(
                playing == false
                    ? Icons.play_circle_outline
                    : Icons.pause_circle_outline,
                size: 100,
              ),
            )
          ],
        ),
        color: Colors.grey[850],
      )
    ];
    return Scaffold(
      //backgroundColor: Colors.grey[900],
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Container(
            child: Scaffold(
          body: listOfBcColor[currentIndex],
          bottomNavigationBar: BottomNavyBar(
            animationDuration: Duration(seconds: 2),
            backgroundColor: Colors.grey[900],
            curve: Curves.elasticInOut,
            selectedIndex: currentIndex,
            onItemSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  icon: Icon(Icons.menu_book_outlined),
                  title: Text(
                    'Blog',
                  ),
                  activeColor: Colors.white60,
                  inactiveColor: Colors.grey[600]),
              BottomNavyBarItem(
                  icon: Icon(Icons.play_circle_outline_outlined),
                  title: Text('Videos'),
                  activeColor: Colors.white60,
                  inactiveColor: Colors.grey[600]),
              BottomNavyBarItem(
                  icon: Icon(Icons.multitrack_audio),
                  title: Text('Audio Book'),
                  activeColor: Colors.white60,
                  inactiveColor: Colors.grey[600]),
            ],
          ),
        )),
      ),
    );
  }

  Widget slider() {
    return Slider.adaptive(
      min: 0.0,
      value: position.inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          audioPlayer.seek(new Duration(seconds: value.toInt()));
        });
      },
    );
  }

  Future<void> getAudio() async {

    if (playing) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    } else {
      var res = await audioPlayer.play(widget.data.audiobookLink, isLocal: true);
      if (res == 1) {
        setState(() {
          playing = true;
        });
      }
      audioPlayer.onDurationChanged.listen((Duration dd) {
        setState(() {
          duration = dd;
        });
      });
      audioPlayer.onAudioPositionChanged.listen((Duration dd) {
        setState(() {
          position = dd;
        });
      });
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('pdfUrl', pdfUrl));
  }
}
