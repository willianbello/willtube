import 'package:flutter/material.dart';
import 'package:willtube/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../api.dart';

class VideoScreen extends StatelessWidget {

  YoutubePlayerController _controller;
  Video _video;

  VideoScreen(Video video) {
    _video = video;

    _controller = new YoutubePlayerController(
      initialVideoId: video.id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _video.title
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Column(
          children: [
            YoutubePlayer(
              key: Key(API_KEY),
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {

              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _video.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Canal: ${_video.channel}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
