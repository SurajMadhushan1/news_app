import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/screens/services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    });
    ApiServices().getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                child: Image.asset(
              "assests/NewsIcon.jpg",
              width: 250,
              height: 250,
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          const SpinKitThreeBounce(
            color: Colors.blue,
            size: 50.0,
          )
        ],
      ),
    );
  }
}
