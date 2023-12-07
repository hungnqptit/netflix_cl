// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:netflix_cl/utils/list_ext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<MovieItem> _listMovie = [];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    // var parser = await Chaleno().load("https://phimmoichill1.net/");
    // final webScraper = WebScraper("https://phimmoichill1.net/");
    final parser = await Chaleno().load("https://phimmoichill1.net/");

    // final contents = parser?.getElementsByClassName('data dfeatur');
    List<Result> title = parser?.getElementsByClassName('item.movies') ?? [];
    for (Result item in title) {
      if (item.id?.contains("featured") ?? false) {
        List<Result>? listItem = item.querySelectorAll(".data.dfeatur");
        List<Result>? listPoster = item.querySelectorAll(".poster > img");
        List<Result>? listStatus =
            item.querySelectorAll(".poster > div.trangthai");
        for (int i = 0; i < (listItem?.length ?? 0); i++) {
          final title = listItem?[i].querySelector("h3>a");
          setState(() {
            _listMovie.add(
              MovieItem(
                title: title?.text,
                link: listItem?[i].href,
                photo: listPoster?[i].src,
                status: listStatus?[i].text,
              ),
            );
          });
        }
      }
    }

    // List<Map<String, dynamic>> contents =
    //     parser.getElement("article.item.movies", ["id"]);
    // // List<Map<String, dynamic>> img =
    // //     webScraper.getElement("div.data.dfeatur > h3 > a", ["href"]);
    // // final content = webScraper.getElement("div.data.dfeatur", ["href"]);
    // // print(contents.);
    // for (var item in contents) {
    //   print(item["attributes"]["id"]);
    //   List<Map<String, dynamic>> poster =
    //       webScraper.getElementById("article.item.movies > ", ["id"]);
    //   // _listMovie.add(MovieItem(
    //   //     title: item["title"], link: item["href"], photo: item.src));
    // }

    // results?.map((item) => print(item.text));

    // final result = await webScraper.loadWebPage('/');

    // if (result) {
    //   final elements = webScraper.getElement("div.owl-wrapper", []);
    //   print(elements);
    // }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Phim nổi bật",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    ..._listMovie
                        .map((e) {
                          // print(e.photo);
                          return SizedBox(
                            width: 150,
                            height: 270,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    e.photo ?? "",
                                    width: 150,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(5),
                                      Text(
                                        e.title ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Gap(2),
                                      Text(
                                        e.status ?? "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                        .toList()
                        .separator(
                          (index) => const Gap(10),
                        ),
                  ],
                ),
              ),
              // ListView.builder(
              //   itemCount: _listMovie.length,
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (context, index) => const Column(
              //     children: [],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MovieItem {
  final String? title;
  final String? link;
  final String? photo;
  final String? status;

  MovieItem({
    required this.title,
    required this.link,
    required this.photo,
    required this.status,
  });

  MovieItem copyWith({
    String? title,
    String? link,
    String? photo,
    String? status,
  }) {
    return MovieItem(
      title: title ?? this.title,
      link: link ?? this.link,
      photo: photo ?? this.photo,
      status: status ?? this.status,
    );
  }
}
