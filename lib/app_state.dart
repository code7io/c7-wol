import 'package:c7_wake_on_lan/model/model_pc.dart';
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
    _hasEntry = prefs.getBool('ff_hasEntry') ?? _hasEntry;
    _pcEntries = prefs.getString('ff_pcEntries') ?? null;

    if (_pcEntries != null) {
      List<dynamic> pcArr = jsonDecode(_pcEntries);

      for (var i = 0; i < pcArr.length; i++) {
        PcModel pc = PcModel.fromJson(pcArr[i]);
        pcList.add(pc);
      }
    }
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

  List<PcModel> _pcList = [];
  List<PcModel> get pcList => _pcList;
  set pcList(List<PcModel> _value) {
    _pcList = _value;
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
