import 'package:shared_preferences/shared_preferences.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _hasEntry = prefs.getBool('ff_hasEntry') ?? _hasEntry;
    _pcEntries = prefs.getString('ff_pcEntries') ?? null;
    _pingTime = prefs.getInt('ff_pingTime') ?? _pingTime;
  }

  SharedPreferences prefs;

  bool _hasEntry = false;
  bool get hasEntry => _hasEntry;
  set hasEntry(bool _value) {
    _hasEntry = _value;
    prefs.setBool('ff_hasEntry', _value);
  }

  String _pcEntries;
  String get pcEntries => _pcEntries;
  set pcEntries(String _value) {
    _pcEntries = _value;
    prefs.setString('ff_pcEntries', _value);
  }

  int _pingTime = 100;
  int get pingTime => _pingTime;
  set pingTime(int _value) {
    _pingTime = _value;
    prefs.setInt('ff_pingTime', _value);
  }
}
