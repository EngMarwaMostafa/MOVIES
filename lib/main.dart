import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/text.dart';
import 'package:flutter_movies_app/widgets/toprated.dart';
import 'package:flutter_movies_app/widgets/trending.dart';
import 'package:flutter_movies_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
    primaryColor: Colors.green),
    );
  }
}
 
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  final String apikey = '67af5e631dcbb4d0981b06996fcd47bc';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FmNWU2MzFkY2JiNGQwOTgxYjA2OTk2ZmNkNDdiYyIsInN1YiI6IjYwNzQ1OTA0ZjkyNTMyMDAyOTFmZDczYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.C_Bkz_T8OybTGo3HfYsESNjN46LBYdw3LHdF-1TzYYs';

 @override
 void initState(){
   loadmovies();
   super.initState();
 }

  loadmovies()async{
  TMDB tmdbWithCustomLogs = TMDB(
  ApiKeys(apikey, readaccesstoken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
  Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
  Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
  setState(() {
    trendingmovies = trendingresult['results'];
    topratedmovies = topratedresult['results'];
    tv = tvresult['results'];
  });
  print(trendingmovies);

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: modified_text(text: 'Flutter Movie App ❤', size: 10, color: Colors.red,),
        backgroundColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            TV(tv: tv),
            TopRated(toprated: topratedmovies,),
            TrendingMovies(trending:trendingmovies)
          ],
        ),
    );
  }
}

