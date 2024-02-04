import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/screens/models/news_model.dart';
import 'package:news_app/screens/services/api_service.dart';
import 'package:news_app/screens/services/web_launch.dart';

class Catogory extends StatefulWidget {
  const Catogory({super.key});

  @override
  State<Catogory> createState() => _CatogoryState();
}

ApiServices service = ApiServices();
String catogoryName = 'General';

class _CatogoryState extends State<Catogory> {
  List<dynamic> catogory = [
    'General',
    'Sports',
    'Business',
    'Health',
    'Entertainment',
    'Science',
    'Apple',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
        child: const Icon(Icons.arrow_back_ios),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        },
      )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catogory.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        catogoryName = catogory[index];
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: catogoryName ==
                                    catogory[
                                        index] // catogory name and pressed names are equal
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            catogory[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder(
                    future: service.getCatogeries(catogoryName),
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(news[index]
                                                    .image
                                                    .toString()))),
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
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Tap to\nRead",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              child: Text(
                                                news[index].date.toString(),
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.3)),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
