import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:willtube/blocs/favorite_bloc.dart';
import 'package:willtube/models/video.dart';
import 'package:willtube/screens/video.dart';

class VideoTile extends StatelessWidget {

  final Video video;

  const VideoTile(this.video, { Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final blocFav = BlocProvider.getBloc<FavoriteBloc>();

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => VideoScreen(video))
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                          child: Text(
                            video.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            video.channel,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        )
                      ],
                    )
                ),
                StreamBuilder<Map<String, Video>>(
                    stream: blocFav.outFav,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        );
                      } else {
                        return IconButton(
                            icon: Icon(
                              snapshot.data.containsKey(video.id) ?
                              Icons.star_sharp : Icons.star_border,
                              color: snapshot.data.containsKey(video.id) ?
                              Colors.amber : Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              blocFav.toggleFavorite(video);
                            }
                        );
                      }
                    }
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
