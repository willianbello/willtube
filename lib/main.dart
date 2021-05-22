import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:willtube/blocs/favorite_bloc.dart';
import 'package:willtube/blocs/videos_bloc.dart';
import 'package:willtube/screens/home.dart';

import 'api.dart';

void main () {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'WillTube',
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
    );
  }
}
