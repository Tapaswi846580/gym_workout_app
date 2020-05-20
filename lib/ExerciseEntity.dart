class Exercise{
  Duration _exerciseDuration;
  String _name;
  String _image;
  String _durationString;
  bool _isCompleted;
  int _currentSet = 0;
  String _music;

  static String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes : $twoDigitSeconds";
  }

  Exercise(this._exerciseDuration, this._name, this._image, this._music)
      : _durationString = "${printDuration(_exerciseDuration)}",
        _isCompleted = false;

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Duration get exerciseDuration => _exerciseDuration;

  set exerciseDuration(Duration value) {
    _exerciseDuration = value;
  }

  String get durationString => _durationString;

  set durationString(String value) {
    _durationString = value;
  }

  bool get isCompleted => _isCompleted;

  set isCompleted(bool value) {
    _isCompleted = value;
  }

  int get currentSet => _currentSet;

  set currentSet(int value) {
    _currentSet = value;
  }


}