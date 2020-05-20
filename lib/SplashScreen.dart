import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreeen extends StatefulWidget {
  @override
  _SplashScreeenState createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen>
    with SingleTickerProviderStateMixin {
  double height = 450, opacity = 1;
  bool flag = false;
  @override
  void initState() {
    loadImage();
    super.initState();
  }

  loadImage() async{
    await Future.delayed(Duration(seconds: 5)).then((value) =>
        setState(() {
          height = MediaQuery.of(context).size.width;
          opacity = 0;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Center(
            child: AnimatedOpacity(
              duration:  Duration(milliseconds: 300),
              opacity: opacity,
              child: AnimatedContainer(
                onEnd: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyHomePage(title: 'Workout')));
                },
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                  width: height,
                  height: height,
                  child: Image.asset(
                    "assets/logo.png",
                    color: Theme.of(context).highlightColor,
                  )),
            )),
      ),
    );
  }
}
