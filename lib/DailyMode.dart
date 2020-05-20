import 'dart:async';
import 'package:intl/intl.dart';
import 'package:quiver/async.dart';
import 'package:flutter/material.dart';
import 'package:gym_workout_app/ExerciseEntity.dart';
import 'package:gym_workout_app/Resources.dart';
import 'package:gym_workout_app/main.dart';
import 'package:assets_audio_player/assets_audio_player.dart';



class DailyMode extends StatefulWidget {
  @override
  _DailyModeState createState() => _DailyModeState();
}

class _DailyModeState extends State<DailyMode> with SingleTickerProviderStateMixin{
  double _height, _width, _itemHeight, fontSize = 50, fontOpacity = 1;//_height/3
  ThemeData _theme;
  int currentExercise = 0;
  List<Exercise> listOfExercise;
  TextEditingController noOfSetsController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool start = false, exerciseBreak = false, pause = false;
  CountdownTimer timer;
  int totalNoOfSets = 1;
  int breakTime = Resources.breakDuration.inSeconds;
  int preStart = Resources.preStart.inSeconds;
  String timerText="";
  int flag = 0;
  int music = 0;
  final assetAudioPlayer = AssetsAudioPlayer();
  AnimationController _controller;

  _DailyModeState(){
    listOfExercise = new List();
  }
  @override
  void initState() {
    getList();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  askForNumberOfSets(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      _theme = Theme.of(context);
      Future.delayed(Duration(milliseconds: 100)).then((_){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context){
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              title: Text("Number of Sets", style: _theme.textTheme.display2,),
              content: TextField(
                keyboardType: TextInputType.number,
                controller: noOfSetsController,
                style: _theme.textTheme.body1,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: "Enter number of set",
                    hintStyle: _theme.textTheme.body2.copyWith(color: _theme.hintColor)
                ),
              ),
              actions: <Widget>[
                FlatButton(onPressed: () {
                  if(noOfSetsController.text.isNotEmpty){
                    Navigator.of(context).pop();
                    setState(() {
                      totalNoOfSets = int.parse(noOfSetsController.text);
                    });
                  }
                }, child: Text("Submit", style: _theme.textTheme.body2,))
              ],
            );
          },
        );
      });
    });
  }

  getList(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        listOfExercise = resources.loadDailyExercises();
      });
      askForNumberOfSets();
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _itemHeight = _height / 4;
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        actions: <Widget>[
          totalNoOfSets == null ? Offstage() : Center(child: Padding(
            padding: EdgeInsets.only(right: _width/10),
            child: Text(
              "Total Sets: $totalNoOfSets", style: _theme.textTheme.subhead.copyWith(fontSize: _width/30),),
          ))
        ],

        title: RichText(text: TextSpan(
          children: [
            TextSpan(text: "Daily Exercise", style: _theme.textTheme.subhead.copyWith(fontSize: _width/25),),
            TextSpan(text: "\n", style: _theme.textTheme.subhead.copyWith(fontSize: _width/25),),
            TextSpan(text: "${DateFormat("dd MMMM yyyy, EEEE").format(DateTime.now())}", style: _theme.textTheme.subhead.copyWith(fontSize: _width/35),)
          ]
        ), ),
        backgroundColor: _theme.primaryColor,
      ),
      body: Container(
        child: Center(
            child: Stack(
              children: <Widget>[
                ScrollConfiguration(
                  behavior: MyScrollBehavior(),
                  child: ListView.builder(
                      itemCount: listOfExercise.length,
                      itemExtent: _itemHeight,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                                border: Border.all(color: index ==
                                    currentExercise && (start || pause) ? Colors
                                    .green : Colors.transparent, width: 5)
                            ),
                            child: CustomCard(
//                          height: _height / 4,
                              width: _width / 1.1,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: Image.asset(listOfExercise[index].image),
                                              ),
                                              Text(
                                                "${listOfExercise[index].name}",
                                                style: _theme.textTheme.headline.copyWith(
                                                    fontSize: _height/20
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            (listOfExercise[index].isCompleted ||
                                                listOfExercise[index].currentSet !=
                                                    0)
                                                ? MainAxisAlignment.spaceEvenly
                                                : MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Duration: ${listOfExercise[index]
                                                    .durationString}",
                                                style: _theme.textTheme.subtitle.copyWith(
                                                    fontSize: _width/20
                                                ),
                                              ),
                                              Visibility(
                                                visible: (listOfExercise[index]
                                                    .isCompleted ||
                                                    listOfExercise[index]
                                                        .currentSet != 0),
                                                child: Flexible(
                                                  child: Text(
                                                    "Set - ${listOfExercise[index]
                                                        .currentSet}",
                                                    style: _theme.textTheme
                                                        .subtitle.copyWith(
                                                        fontSize: _width/20
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  AnimatedOpacity(
                                    duration: Duration(milliseconds: 500),
                                    opacity: listOfExercise[index].isCompleted
                                        ? 1
                                        : 0,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: _height / 20,
                                        width: _height / 20,
                                        padding: EdgeInsets.only(left: 3, top: 3),
                                        decoration: BoxDecoration(
                                            color: _theme.primaryColor,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(
                                                    _height / 20)
                                            )
                                        ),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Icon(Icons.done,
                                              color: _theme.backgroundColor,size: _height/30,)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
                Visibility(
                  visible: ((start == true && flag == 0) || (exerciseBreak)),
                  child: Container(
                    width: _width,
                    height: _height,
                    color: Color(0xff121212).withOpacity(0.7),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Visibility(
                            visible: exerciseBreak,
                            child: Text("Take a break !", style: _theme.textTheme.headline.copyWith(
                                fontSize: _width/10,
                                color: Colors.white
                            ),),
                          ),
                        ),

                        Center(
                          child: AnimatedOpacity(
                            opacity: fontOpacity,
                            duration: Duration(milliseconds: 250),
                            child: AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 250),
                              style: _theme.textTheme.display1.copyWith(
                                  fontSize: fontSize,
                                  color: Colors.white
                              ),
                              child: Text(timerText,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
        ),
      ),
      floatingActionButton: AbsorbPointer(
        absorbing: ((start == true && flag == 0) || exerciseBreak),
        child: FloatingActionButton(
          backgroundColor: _theme.primaryColor,
          onPressed: () {
            setState(() {
              start = !start;
              if(start){
                _controller.forward();
                startExercise();
              }
              else {
                _controller.reverse();
                pauseExercise();
              }
            });
          },
          child: AnimatedIcon(icon: AnimatedIcons.play_pause, color: _theme.backgroundColor, progress: _controller),/*Icon(
            start ? Icons.pause : Icons.play_arrow,
            color: _theme.backgroundColor,)*/),
      ),
    );
  }

  preStartExercise() async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      fontSize = 150;
      fontOpacity = 0;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      preStart--;
      timerText = "${preStart == 0 ? "Start !" : "$preStart"}";
      fontSize = 50;
      fontOpacity = 1;
    });
    if(preStart != -1)
      preStartExercise();
    else{
      setState(() {
        start = true;
        flag = 1;
        timerText = "";
        assetAudioPlayer.open(resources.listOfMusic[currentExercise == resources.listOfMusic.length ? 0 : currentExercise], autoStart: false,);
        assetAudioPlayer.loop = true;
        assetAudioPlayer.play();
        startExercise();
      });
    }
  }
  startBreak() async{
    assetAudioPlayer.pause();
    setState(() {
      exerciseBreak = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      fontSize = 200;
      fontOpacity = 0;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      timerText = "${--breakTime}";
      fontSize = 50;
      fontOpacity = 1;
    });
    if (breakTime != -1)
      startBreak();
    else {
      setState(() {
        breakTime = Resources.breakDuration.inSeconds;
        timerText = "";
        exerciseBreak = false;
        assetAudioPlayer.play();
      });
    }
  }


  int mins;
  int secs;
  Duration pauseDuration;
  int currentSet = 0;
  startExercise() {
    if(flag == 0)
      preStartExercise();
    else{
      if(currentExercise == listOfExercise.length){
        reset();
      }
      if(pause){
        assetAudioPlayer.play();
        pause = false;
      }
      else{
        currentSet++;
      }
      scrollController.animateTo(currentExercise * _itemHeight, duration: new Duration(seconds: 1), curve: Curves.ease);
      Exercise exercise = listOfExercise[currentExercise];
      setState(() => exercise.currentSet = currentSet);
      mins = pauseDuration == null ? exercise.exerciseDuration.inMinutes : pauseDuration.inMinutes;
      secs = pauseDuration == null ? exercise.exerciseDuration.inSeconds : pauseDuration.inSeconds;
      timer = CountdownTimer(
        pauseDuration == null ? exercise.exerciseDuration : pauseDuration,
        Duration(seconds: 1),
      );

      timer.listen((duration) {
        setState(() {
          if (secs.remainder(60) == 0) {
            mins--;
          }
          secs--;
          exercise.durationString = "${mins >= 10 ? "$mins" : "0$mins"} :"
              " ${secs.remainder(60) >= 10 ? "${secs.remainder(60)}" : "0${secs
              .remainder(60)}"}";
        });
      },
          onDone: () async{
            if(!pause){
              if(currentSet == totalNoOfSets){
                currentExercise++;
                if(currentExercise != resources.listOfMusic.length)
                  assetAudioPlayer.open(resources.listOfMusic[currentExercise], autoStart: false,);
                assetAudioPlayer.loop = true;
                currentSet = 0;
                exercise.isCompleted = true;
              }
              pauseDuration = null;
              timer.cancel();
              if (currentExercise < listOfExercise.length) {
                startBreak();
                await Future.delayed(Duration(seconds: Resources.breakDuration.inSeconds+1)).then((_){
                  startExercise();
                });
              }
              else{
                setState((){
                  assetAudioPlayer.stop();
                  breakTime = Resources.breakDuration.inSeconds;
                  preStart = Resources.preStart.inSeconds;
                  start = false;
                  flag = 0;
                });
              }
            }else{
              setState(() {
                pauseDuration = Duration(seconds: exercise.exerciseDuration.inSeconds - timer.elapsed.inSeconds);
              });
            }
          }
      );
    }


  }

  void reset(){
    currentExercise = 0;
    currentSet = 0;
    breakTime = Resources.breakDuration.inSeconds;
    preStart = Resources.preStart.inSeconds;
    listOfExercise.forEach((exercise) {
      setState(() {
        exercise.durationString = Exercise.printDuration(exercise.exerciseDuration);
        exercise.isCompleted = false;
        exercise.currentSet = 0;
      });
    });
  }

  pauseExercise(){
    assetAudioPlayer.pause();
    pause = true;
    timer.cancel();
  }

  @override
  void dispose() {
    resources.loadExercise();
    listOfExercise.clear();
    assetAudioPlayer.dispose();
    super.dispose();
  }
}
