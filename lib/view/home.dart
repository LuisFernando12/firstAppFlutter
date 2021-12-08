import 'package:apps_flutter/class/movies.dart';
import 'package:apps_flutter/class/series.dart';
import 'package:apps_flutter/view/overview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SmartMovies extends State<SmartMoviesHome> {
  final _movies = <Movies>[];
  final _series = <Series>[];
  final _font = const TextStyle(fontSize: 18.0, color: Colors.white);
  late ScrollController _controllerFilm;
  late ScrollController _controllerSerie;
  int pageFilme = 1;
  int pageSerie = 1;
  @override
  void initState() {
    super.initState();
    _controllerFilm = ScrollController();
    _controllerFilm.addListener(_reloadMovies);

    _controllerSerie = ScrollController();
    _controllerSerie.addListener(_reloadSerie);
    setState(() {
      pageFilme;
      pageSerie;
    });
    _loadSerie();
    _loadMovies();
  }

  _loadMovies() async {
    try {
      var url = Uri.parse(
          "https://api-movies-series.herokuapp.com/filmes?page= $pageFilme");
      var response = await http.get(url);
      for (var movies in jsonDecode(response.body)["results"]) {
        _movies.add(Movies(
            movies["id"],
            movies["title"] ?? "Title",
            movies["overview"] ?? "Sinopse",
            movies["poster_path"] ?? "",
            movies["backdrop_path"] ?? movies["poster_path"] ?? "",
            movies["adult"] ?? false,
            "filmes"));
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _movies;
    });
  }

  _loadSerie() async {
    try {
      var urlSeries = Uri.parse(
          "https://api-movies-series.herokuapp.com/series?page= $pageSerie");
      var responseSeries = await http.get(urlSeries);
      final seriesJson = jsonDecode(responseSeries.body);
      for (var series in seriesJson["results"]) {
        _series.add(Series(
            series["id"],
            series["original_name"] ?? "Um titulo qualquer",
            series["overview"] ?? "",
            series["poster_path"] ?? "",
            series["backdrop_path"] ?? series["poster_path"] ?? "",
            series["adult"] ?? false,
            "series"));
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _series;
    });
  }

  Future<void> _reloadMovies() async {
    await Future.delayed(
        const Duration(seconds: 4),
        () => {
              setState(() {
                pageFilme++;
              })
            });
    _loadMovies();
  }

  Future<void> _reloadSerie() async {
    await Future.delayed(
        const Duration(seconds: 4),
        () => {
              setState(() {
                pageSerie++;
              })
            });
    _loadSerie();
  }

  @override
  Widget build(BuildContext context) {
    if (_movies.isEmpty || _series.isEmpty) {
      return const CircularProgressIndicator(
        color: Colors.white,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _movies.length,
              controller: _controllerFilm,
              itemBuilder: (BuildContext context, int position) => Card(
                  child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Overview(movie: _movies[position])),
                  );
                },
                child: Container(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                          width: 300,
                          height: 200,
                          imageUrl: _movies[position].backdrop_path,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover),
                      Text(
                        _movies[position].title,
                        style: _font,
                      )
                    ],
                  ),
                  margin: const EdgeInsets.all(5),
                ),
              )),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: _series.length,
              controller: _controllerSerie,
              itemBuilder: (ctx, int index) {
                return Card(
                    child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Overview(movie: _series[index])),
                    );
                  },
                  child: Container(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                            imageUrl: _series[index].backdrop_path,
                            width: 300,
                            height: 200,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover),
                        Text(
                          _series[index].original_name,
                          style: _font,
                        )
                      ],
                    ),
                    margin: const EdgeInsets.all(5),
                  ),
                ));
              },
            ),
          ),
        ],
      );
    }
  }
}

class SmartMoviesHome extends StatefulWidget {
  const SmartMoviesHome({Key? key}) : super(key: key);

  @override
  createState() => SmartMovies();
}
