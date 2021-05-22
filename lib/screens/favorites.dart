import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:willtube/api.dart';
import 'package:willtube/blocs/favorite_bloc.dart';
import 'package:willtube/models/video.dart';
import 'package:willtube/screens/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Favorites extends StatelessWidget {

  final blocFav = BlocProvider.getBloc<FavoriteBloc>();

  Favorites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos'
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
      ),
      backgroundColor: Colors.white10,
      body: StreamBuilder<Map<String, Video>>(
        stream: blocFav.outFav,
        initialData: {},
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data.values.map((video) =>
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VideoScreen(video))
                    );
                  },
                  onLongPress: () {
                    blocFav.toggleFavorite(video);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(video.thumb),
                      ),
                      Expanded(
                        child: Text(
                          video.title,
                          style: TextStyle(
                            color: Colors.white70
                          ),
                          maxLines: 2,
                        )
                      )
                    ],
                  ),
                )
              ).toList(),
            );
          }
        },
      ),
    );
  }
}
