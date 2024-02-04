import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/screens/catogories.dart';
import 'package:news_app/screens/models/news_model.dart';
import 'package:news_app/screens/services/api_service.dart';
import 'package:news_app/screens/services/web_launch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices service = ApiServices();
  List<NewsModel>? news = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu),
                const Text(
                  "News",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                InkWell(
                  child: const Text(
                    "More",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Catogory(),
                        ));
                  },
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 6, top: 6),
              child: Text(
                "US Headlines",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 4,
            color: Colors.black.withOpacity(0.5),
          ),
          FutureBuilder(
            future: service.getHeadlines(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                news = snapshot.data;
                return CarouselSlider(
                  options: CarouselOptions(height: 180.0, autoPlay: true),
                  items: news!.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken,
                                ),
                                image: NetworkImage(i.image.toString()),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    i.title.toString(),
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 7,
                                  left: 5,
                                  child: Text(
                                    i.date.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            WebLaunch.loadWeb(i.url.toString());
                          },
                        );
                      },
                    );
                  }).toList(),
                );
              } else {
                return const SpinKitCircle(
                  color: Colors.blue,
                  size: 50.0,
                );
              }
            },
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 6, top: 6),
              child: Text(
                "BBC Headlines",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 4,
            color: Colors.black.withOpacity(0.5),
          ),
          FutureBuilder(
            future: service.getBBCHeadlines(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NewsModel>? news = snapshot.data;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: news!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          WebLaunch.loadWeb(news[index].url.toString());
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            news[index].image.toString()))),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: Container(
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Tap to\nRead",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 40,
                                      child: SizedBox(
                                        width: 200,
                                        child: Text(
                                          news[index].title.toString(),
                                          maxLines: 3,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      child: Text(
                                        news[index].date.toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.3)),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              );
            },
          ),
        ],
      ),
    );
  }
}
