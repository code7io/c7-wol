import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) => Localizations.of<FFLocalizations>(context, FFLocalizations);

  static List<String> languages() => ['en', 'de'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode) ? languages().indexOf(languageCode) : 0;

  String getText(String key) => (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String enText = '',
    String deText = '',
  }) =>
      [enText, deText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => FFLocalizations.languages().contains(locale.languageCode);

  @override
  Future<FFLocalizations> load(Locale locale) => SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    'mpdc0m1f': {
      'en': 'C7 Wake on Lan',
      'de': '',
    },
    'tymw1z50': {
      'en': 'PC Name',
      'de': 'PC Name',
    },
    '4oylz3oi': {
      'en': 'IP or MAC',
      'de': 'IP oder MAC',
    },
    'dxt0pvdz': {
      'en': 'No PC added yet. Press the button in the upper right to add your first PC',
      'de': '',
    },
    'qcxnnr8b': {
      'en': 'Home',
      'de': 'Home',
    },
  },
  // Detail
  {
    'bied3soc': {
      'en': 'Shutdown',
      'de': 'Herunterfahren',
    },
    '7a9edt5f': {
      'en': 'Restart',
      'de': 'Neustarten',
    },
    '7pqir15j': {
      'en': 'PC Name:',
      'de': 'PC Name:',
    },
    'd2ke4olt': {
      'en': 'MAC Address:',
      'de': 'MAC Adresse:',
    },
    'g2lrrb9y': {
      'en': 'IP Address:',
      'de': 'IP Adresse:',
    },
    'ml43v9az': {
      'en': 'Port:',
      'de': 'Port:',
    },
    'go5528js': {
      'en': 'Delete',
      'de': 'Löschen',
    },
    'dm30m5ug': {
      'en': 'Home',
      'de': 'Home',
    },
    'ywclyvhz': {
      'en': 'Status',
      'de': 'Status',
    },
    'onqfweaponi': {
      'en': 'Offline',
      'de': 'Aus',
    },
    'qpnifeppolwdd': {
      'en': 'Online',
      'de': 'An',
    },
    'avu7ysio': {
      'en': 'Sleep',
      'de': 'Standby',
    },
    'uonfaasffsa': {
      'en': 'Cancel',
      'de': 'Abbrechen',
    },
    'afsadgfshghe': {
      'en': 'Really Delete?',
      'de': 'Wirklich Löschen?',
    },
    'owuehbnfiwbbubebbbsedf': {
      'en': 'Do you want to really delete this PC?',
      'de': 'Willst du wirklich diesen PC löschen?',
    },
  },
  // AddPc
  {
    '9urjz9rj': {
      'en': 'Add a PC',
      'de': 'Fügen Sie einen PC hinzu',
    },
    'ep5gbmfs': {
      'en': 'PC Name',
      'de': 'PC Name',
    },
    'iir0hzqn': {
      'en': 'MAC Address',
      'de': 'MAC Adresse',
    },
    'o2n760uf': {
      'en': 'IP Address',
      'de': 'IP Adresse',
    },
    'wvrblzc7': {
      'en': 'Port',
      'de': 'Port',
    },
    'wxw0kag1': {
      'en': 'Field is required',
      'de': 'Feld ist erforderlich',
    },
    'r4gvx61c': {
      'en': 'Min. 3 Characters',
      'de': 'Mindest. 3 Zeichen',
    },
    'f294ttpe': {
      'en': 'Field is required',
      'de': 'Feld ist erforderlich',
    },
    'y4j45zr5': {
      'en': 'Field is required',
      'de': 'Feld ist erforderlich',
    },
    'xzr4qcs7': {
      'en': 'Field is required',
      'de': 'Feld ist erforderlich',
    },
    'a0u6v4zo': {
      'en': 'Add',
      'de': 'Hinzufügen',
    },
    'wi80cq94': {
      'en': 'Home',
      'de': 'Home',
    },
    'cn09qewf': {
      'en': 'IP Address invalid',
      'de': 'IP Adresse ungültig',
    },
    'pqownfdw': {
      'en': 'MAC Address invalid',
      'de': 'MAC Adresse ungültig',
    },
  },
  // SearchNetwork
  {
    '0nfkq8eq': {
      'en': 'Analyzing Network',
      'de': 'Netzwerk analysieren',
    },
    '3135dyww': {
      'en': 'Found Devices',
      'de': 'Gefundene Geräte',
    },
    'weifbuew': {
      'en': 'No Device found. Manually enter info',
      'de': 'Kein Gerät gefunden. Manuell hinzufügen',
    },
  },
  // Settings
  {
    'wedfnowfewef': {
      'en': 'Settings',
      'de': 'Einstellungen',
    },
    'wfmkmdckskld': {
      'en': 'Ping duration during network scan',
      'de': 'Ping Dauer beim Netzwerkscan',
    },
    'sdcmsölkdcvökmsd': {
      'en': 'App version',
      'de': 'App Version',
    },
    'adcmösdkckdsc': {
      'en': 'Made in Mannheim with ❤️',
      'de': 'Mit ❤️ in Mannheim gemacht',
    },
    'cmowic03i23ic0cc': {
      'en': 'By code7.io',
      'de': 'Von code7.io',
    },
  },
].reduce((a, b) => a..addAll(b));
