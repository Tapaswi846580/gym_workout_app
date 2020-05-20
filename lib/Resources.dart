import 'dart:math';

import 'package:assets_audio_player/playable.dart';
import 'package:flutter/material.dart';
import 'package:gym_workout_app/ExerciseEntity.dart';

class Resources{

  static Duration breakDuration = Duration(seconds: 4);
  static Duration preStart = Duration(seconds: 4);

  List<Exercise> _listOfExercise;
  List<Audio> _listOfMusic;

  List<Audio> get listOfMusic => _listOfMusic;

  Map<int, String> temp = Map();

  loadMusic(){
    _listOfMusic = List();
    _listOfMusic.add(Audio("assets/audio/50_Up_from_the_ashes.mp3"));
    _listOfMusic.add(Audio("assets/audio/joined_audio.mp3"));
    _listOfMusic.add(Audio("assets/audio/Song_14_Rock.mp3"));
    _listOfMusic.add(Audio("assets/audio/Song_18_Rock.mp3"));
    _listOfMusic.add(Audio("assets/audio/Song_34_Pop.mp3"));
  }

  loadExercise(){
    _listOfExercise = List();
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Back Streching", "assets/back_streching.png",
        "assets/audio/50_Up_from_the_ashes.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Bench Press", "assets/bench_press.png",
        "assets/audio/Song_14_Rock.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Bisceps", "assets/bisceps.png",
        "assets/audio/Song_18_Rock.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Crunches", "assets/crunches.png",
        "assets/audio/Song_34_Pop.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Decline Crunch", "assets/decline_crunch.png",
        "assets/audio/50_Up_from_the_ashes.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Dumbel Pushups", "assets/dumbel_pushups.png",
        "assets/audio/Song_14_Rock.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Gym Ball", "assets/gym_ball.png",
        "assets/audio/Song_18_Rock.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Inclined Press", "assets/inclined_press.png",
        "assets/audio/Song_34_Pop.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Leg Streching", "assets/leg_streching.png",
        "assets/audio/50_Up_from_the_ashes.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Meditation", "assets/meditation.png",
        "assets/audio/joined_audio.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Push Ups", "assets/push_ups.png",
        "assets/audio/Song_14_Rock.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Rowing Machine", "assets/rowing_machine.png",
        "assets/audio/Song_18_Rock.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Shoulder Press", "assets/shoulder_press.png",
        "assets/audio/Song_34_Pop.mp3"));
    _listOfExercise.add(Exercise(
        Duration(seconds: 10), "Shoulder Streching",
        "assets/shoulder_streching.png", "assets/audio/joined_audio.mp3"));
  }

  List<Exercise> loadRandomExercises(){
    Set<Exercise> randomExercises = Set();
    while(randomExercises.length != 5){
      randomExercises.add(_listOfExercise[Random().nextInt(_listOfExercise.length)]);
    }
    return randomExercises.toList();
  }

  List<Exercise> loadDailyExercises(){
    String dailyIndices = temp[DateTime.now().weekday];
    Set<Exercise> dailyExercises = Set();
    dailyIndices.split(",").forEach((element) {
      dailyExercises.add(_listOfExercise[int.parse(element)]);
    });

    return dailyExercises.toList();
  }

  Resources(){
    loadExercise();
    loadMusic();
    temp[1] = "0,1,2,3,4";
    temp[2] = "1,2,3,4,5";
    temp[3] = "2,3,4,5,6";
    temp[4] = "3,4,5,6,7";
    temp[5] = "4,5,6,7,8";
    temp[6] = "9,10,11,12,13";
    temp[7] = "3,4,5,6,7";
  }

}
class MyScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Resources resources;