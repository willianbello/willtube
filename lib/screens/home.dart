import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:willtube/blocs/favorite_bloc.dart';
import 'package:willtube/blocs/videos_bloc.dart';
import 'package:willtube/delegates/data_search.dart';
import 'package:willtube/models/video.dart';
import 'package:willtube/screens/favorites.dart';
import 'package:willtube/widgets/video_tile.dart';

class Home extends StatelessWidget {

  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.getBloc<VideosBloc>();
    final blocFav = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('images/willtube_logo.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.white10,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: blocFav.outFav,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Text('0');
                } else {
                  return Text(
                    '${snapshot.data.length}'
                  );
                }
              },
            ),
          ),
          IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Favorites())
                );
              }
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if (result != null) bloc.inSearch.add(result);
            }
          )
        ],
      ),
      backgroundColor: Colors.white10,
      body: StreamBuilder(
        stream: bloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          else {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              }
            );
          }
        },
      ),
    );
  }
}
