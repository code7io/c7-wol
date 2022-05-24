import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

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
    _pcs = prefs.getStringList('ff_pcs') ?? _pcs;
    _hasEntry = prefs.getBool('ff_hasEntry') ?? _hasEntry;
    _pcEntries = prefs.getStringList('ff_pcEntries')?.map((x) {
          try {
            return jsonDecode(x);
          } catch (e) {
            print("Can't decode persisted json. Error: $e.");
            return {};
          }
        })?.toList() ??
        _pcEntries;
  }

  SharedPreferences prefs;

  List<String> _pcs = [];
  List<String> get pcs => _pcs;
  set pcs(List<String> _value) {
    _pcs = _value;
    prefs.setStringList('ff_pcs', _value);
  }

  void addToPcs(String _value) {
    _pcs.add(_value);
    prefs.setStringList('ff_pcs', _pcs);
  }

  void removeFromPcs(String _value) {
    _pcs.remove(_value);
    prefs.setStringList('ff_pcs', _pcs);
  }

  bool _hasEntry = false;
  bool get hasEntry => _hasEntry;
  set hasEntry(bool _value) {
    _hasEntry = _value;
    prefs.setBool('ff_hasEntry', _value);
  }

  List<dynamic> _pcEntries = [];
  List<dynamic> get pcEntries => _pcEntries;
  set pcEntries(List<dynamic> _value) {
    _pcEntries = _value;
    prefs.setStringList(
        'ff_pcEntries', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToPcEntries(dynamic _value) {
    _pcEntries.add(_value);
    prefs.setStringList(
        'ff_pcEntries', _pcEntries.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPcEntries(dynamic _value) {
    _pcEntries.remove(_value);
    prefs.setStringList(
        'ff_pcEntries', _pcEntries.map((x) => jsonEncode(x)).toList());
  }
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
