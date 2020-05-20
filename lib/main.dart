import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_workout_app/DailyMode.dart';
import 'dart:math' as math;

import 'package:gym_workout_app/RandomMode.dart';
import 'package:gym_workout_app/Resources.dart';
import 'package:gym_workout_app/SplashScreen.dart';
import 'package:gym_workout_app/about.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  resources = Resources
    ();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
          backgroundColor: Color(0xff121212),
          primaryColor: Color(0xff8ab4f3),//AppBar
          buttonColor: Color(0xff8ab4f3),
          cardColor: Color(0xff1e1e1e),//0xff121212
          primaryColorLight: Colors.grey.shade800,
          highlightColor: Colors.white,
          disabledColor: Color(0xff8ab4f3).withOpacity(0.9),
          dialogBackgroundColor: Color(0xff1e1e1e),
          cursorColor: Color(0xff8ab4f3),
          hintColor: Color(0xff8ab4f3).withOpacity(0.5),
          textTheme: TextTheme(
              title: GoogleFonts.playfairDisplay(
                  fontSize: 70,
                  color: Colors.white,
                  fontFeatures: [FontFeature.enable('smcp')]),
              subtitle: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xff8ab4f3),
                  fontWeight: FontWeight.bold),
              body1: GoogleFonts.playfairDisplay(
                  fontSize: 20, color: Colors.white),
              body2: GoogleFonts.playfairDisplay(
                  fontSize: 15, color: Color(0xff8ab4f3)),

              headline: GoogleFonts.badScript(
                  fontSize: 50, color: Colors.white),

              display1: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xff1e1e1e),
                  fontWeight: FontWeight.bold),

              display2: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xff8ab4f3),
                  fontWeight: FontWeight.bold),

              subhead: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xff121212),
                  fontWeight: FontWeight.bold)
          )),
      theme: ThemeData(
          backgroundColor: Color(0xfffafafa),
          primaryColor: Color(0xff1973e8), //AppBar
          buttonColor: Color(0xff1973e8),
          cardColor: Color(0xffffffff),
          primaryColorLight: Colors.grey.shade300,
          highlightColor: Color(0xff121212),
          disabledColor: Colors.grey.shade400,
          dialogBackgroundColor: Color(0xffffffff),
          cursorColor: Color(0xff1973e8),
          hintColor: Colors.grey.shade400,
          textTheme: TextTheme(
              title: GoogleFonts.playfairDisplay(
                  fontSize: 70,
                  color: Color(0xff121212),
                  fontFeatures: [FontFeature.enable('smcp')]),
              subtitle: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xff1973e8),
                  fontWeight: FontWeight.bold),
              body1: GoogleFonts.playfairDisplay(
                  fontSize: 20, color: Color(0xff121212)),
              body2: GoogleFonts.playfairDisplay(
                  fontSize: 15, color: Color(0xff1973e8)),
              headline: GoogleFonts.badScript(
                  fontSize: 50, color: Color(0xff121212)),
              display1: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.bold),
              display2: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Color(0xff1973e8),
                  fontWeight: FontWeight.bold),
              subhead: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)
          )),
      home: SplashScreeen()//MyHomePage(title: 'Workout'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _height, _width;
  ThemeData _theme;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Workout",
          style: _theme.textTheme.subhead,
        ),
        backgroundColor: _theme.primaryColor,
      ),
      body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: (_height / 100)*7),
                child: Align(alignment: Alignment.topCenter, child:
                Text(
                  "Select Exercise Mode",
                  style: _theme.textTheme.headline.copyWith(fontSize: _width / 10, shadows: [
                    Shadow(
                      color: _theme.disabledColor, blurRadius: 3, offset: Offset(4, 4)
                    ),
                  ]),
                )),
              ),
              ModeSwitch(),
              Align(
                alignment: Alignment(0, .8),
                child: RaisedButton(

                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Theme
                            .of(context)
                            .primaryColor)
                    ),
                    focusElevation: 0,
                    elevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    color: Theme
                        .of(context)
                        .backgroundColor,
                    splashColor: Theme
                        .of(context)
                        .disabledColor,
                    highlightColor: Colors.transparent,
                    onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => About())),
                    child: Text("About Developer", style: Theme
                        .of(context)
                        .textTheme
                        .body1.copyWith(fontSize: 15),))
              )
            ],
          )
        /*Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CustomCard(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.1,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Random",
                  style: theme.textTheme.title,
                ),
                Text(
                  "Random 5 Exercise",
                  style: theme.textTheme.subtitle,
                )
              ],
            )),
          ),
          CustomCard(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Day Wise",
                  style: theme.textTheme.title,
                ),
                Text(
                  "Daily 5 Exercise",
                  style: theme.textTheme.subtitle,
                ),
              ],
            )),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.1,
          ),
        ],
      )*/
      ),
    );
  }
}

class ModeSwitch extends StatefulWidget {
  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}
class _ModeSwitchState extends State<ModeSwitch> {
  double _parentHeight = 100;
  double _childHeight2 = 80;
  bool _flag = false, _tapFlag = true;
  ValueNotifier<double> valueListener = ValueNotifier(.0);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: _parentHeight, width: 100,
          decoration: BoxDecoration(
              color: _theme.backgroundColor,
              borderRadius: BorderRadius.circular(100),
            border: Border.all(color: _theme.primaryColor,),
            boxShadow: [
              BoxShadow(
                  color: _theme.disabledColor,
                  blurRadius: 5,
                  offset: Offset(3, 3)
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                          visible: _flag,
                          child: Text("Random",
                            style: _theme.textTheme.display1.copyWith(
                                fontSize: 15, color: _theme.primaryColor),)),
                      Visibility(visible: _flag,
                          child: Text("Daily",
                              style: _theme.textTheme.display1.copyWith(
                                  fontSize: 15, color: _theme.primaryColor))),
                    ],
                  ),
                ),

                AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      height: _parentHeight,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                        child: Listener(
                          onPointerDown: (value) {
                            setState(() {
                              _parentHeight = MediaQuery.of(context).size.height / 2;
                              _childHeight2 = 75;
                              _tapFlag = false;
                            });
                            Future.delayed(Duration(milliseconds: 100)).then((_){
                              setState(() {
                                _flag = true;
                              });
                            });
                          },
                          onPointerUp: (value) => setState(() {
                            if (valueListener.value == 1.0) {
                              Navigator.of(context).push(_createRoute(DailyMode())).then((_){
                                setState(() {
                                  _parentHeight = 100;
                                  _childHeight2 = 80;
                                  valueListener.value = 0.0;
                                  _flag = false;
                                  _tapFlag = true;
                                });
                              });
                            } else if (valueListener.value == -1.0) {
                              Navigator.of(context).push(_createRoute(RandomMode())).then((_){
                                setState(() {
                                  _parentHeight = 100;
                                  _childHeight2 = 80;
                                  valueListener.value = 0.0;
                                  _flag = false;
                                  _tapFlag = true;
                                });
                              });
                            }else{
                              _parentHeight = 100;
                              _childHeight2 = 80;
                              valueListener.value = 0.0;
                              _flag = false;
                              _tapFlag = true;
                            }


                          }),
                          child: AnimatedBuilder(
                            animation: valueListener,
                            builder: (context,child){
                              return Align(
                                  alignment: Alignment(.0, valueListener.value),
                                  child: child
                              );
                            },
                            child: GestureDetector(
                              onVerticalDragUpdate: (details){
                                valueListener.value = (valueListener.value +
                                    double.parse(details.delta.dy.toStringAsFixed(2))/100).clamp(-1.0, 1.0);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                width: _childHeight2,
                                height: _childHeight2,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: _theme.disabledColor,
                                        blurRadius: 5,
                                        offset: Offset(1, 1)
                                    )
                                  ],
                                    color: _theme.backgroundColor,
                                    borderRadius: BorderRadius.circular(_childHeight2/2),
                                  border: Border.all(color: _theme.primaryColor)
                                ),
                                child: Center(
                                  child: Text("🏋🏻"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Visibility(
            visible: _tapFlag,
              child: Text("Tap to select", style: _theme.textTheme.body1.copyWith(fontSize: 14,),)),
        )

      ],
    );
  }

  Route _createRoute(Widget screen){
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => screen is RandomMode ? RandomMode() : DailyMode(),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          var begin = screen is RandomMode ?  Offset(0.0, 1.0) : Offset(0.0, -1.0);;
          var end = Offset(0.0, 0.0);
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
              position: offsetAnimation,
              child: child
          );
        }
    );
  }

  @override
  void dispose() {
    _parentHeight = 100;
    _childHeight2 = 80;
    valueListener.value = 0.0;
    _flag = false;
    _tapFlag = true;
    super.dispose();
  }
}


class CustomCard extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;

  CustomCard({this.child, this.height, this.width});

  @override
  _CustomCardState createState() => _CustomCardState();
}
class _CustomCardState extends State<CustomCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Listener(
      onPointerDown: (val) => setState(() => _isPressed = true),
      onPointerUp: (val) => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColorLight,
//                offset: -Offset(5, 5),
                spreadRadius: _isPressed ? 5 : 0,
                blurRadius: 10,
              ),
              BoxShadow(
                color: theme.primaryColorLight,
                spreadRadius: _isPressed ? 5 : 0,
//                offset: Offset(5, 5),
                blurRadius: 10,
              ),
            ]),
        child: Material(
            color: theme.cardColor,
            child: InkWell(
              splashColor: theme.backgroundColor,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: widget.child,
            )),
      ),
    );
  }
}
