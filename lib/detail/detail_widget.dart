import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:c7_wake_on_lan/custom/WakeOnLanCustom.dart';
import 'package:c7_wake_on_lan/model/model_pc.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailWidget extends StatefulWidget {
  const DetailWidget({Key key, this.pc}) : super(key: key);

  final PcModel pc;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String status = '...';
  String name;
  String ip;
  String port;

  @override
  void initState() {
    super.initState();
    statusTxt(context);

    setState(() => name = widget.pc.name);
    setState(() => ip = widget.pc.ip);
    setState(() => port = widget.pc.port);
  }

  Future<void> statusTxt(context) async {
    Ping ping = Ping(widget.pc.ip, count: 5);
    ping.stream.listen((event) {
      if (event.summary.received == event.summary.transmitted) {
        setState(() => status = FFLocalizations.of(context).getText('qpnifeppolwdd'));
      } else {
        setState(() => status = FFLocalizations.of(context).getText('onqfweaponi'));
      }
    });
  }

  void updateName(val) {
    setState(() => name = val);

    String entries = FFAppState().pcEntries;
    List<dynamic> list = jsonDecode(entries);
    List<dynamic> newList = [];

    for (var i = 0; i < list.length; i++) {
      if (list[i]['mac'] == widget.pc.mac) {
        list[i]['name'] = val;
      }
      newList.add(list[i]);
    }

    String entriesNew = jsonEncode(newList);
    FFAppState().pcEntries = entriesNew;
  }

  void updateIp(val) {
    setState(() => ip = val);

    String entries = FFAppState().pcEntries;
    List<dynamic> list = jsonDecode(entries);
    List<dynamic> newList = [];

    for (var i = 0; i < list.length; i++) {
      if (list[i]['mac'] == widget.pc.mac) {
        list[i]['ip'] = val;
      }
      newList.add(list[i]);
    }

    String entriesNew = jsonEncode(newList);
    FFAppState().pcEntries = entriesNew;
  }

  void updatePort(val) {
    setState(() => port = val);

    String entries = FFAppState().pcEntries;
    List<dynamic> list = jsonDecode(entries);
    List<dynamic> newList = [];

    for (var i = 0; i < list.length; i++) {
      if (list[i]['mac'] == widget.pc.mac) {
        list[i]['port'] = val;
      }
      newList.add(list[i]);
    }

    String entriesNew = jsonEncode(newList);
    FFAppState().pcEntries = entriesNew;
  }

  void deletePc() {
    String entries = FFAppState().pcEntries;
    List<dynamic> list = jsonDecode(entries);
    List<dynamic> newList = [];

    for (var i = 0; i < list.length; i++) {
      if (list[i]['mac'] != widget.pc.mac) {
        newList.add(list[i]);
      }
    }

    if (newList.length < 1) {
      FFAppState().hasEntry = false;
    }

    String entriesNew = jsonEncode(newList);
    FFAppState().pcEntries = entriesNew;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_ios,
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePageWidget(),
              ),
            );
          },
        ),
        title: Text(
          name,
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          MACAddress macAddress = MACAddress(widget.pc.mac);
                          IPv4Address ipv4Address = IPv4Address(widget.pc.ip);
                          WakeOnLAN wol = WakeOnLAN(ipv4Address, macAddress, port: int.parse(widget.pc.port));
                          await wol.wake().then((res) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Starting PC',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: Duration(milliseconds: 2000),
                                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                              ),
                            );
                          }, onError: (err) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Error while starting PC',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                duration: Duration(milliseconds: 2000),
                                backgroundColor: FlutterFlowTheme.of(context).alternate,
                              ),
                            );
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.power_settings_new,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                              'ywclyvhz' /* Status */,
                            ) +
                            ': ' +
                            status,
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).subtitle1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Coming soon',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              duration: Duration(milliseconds: 2000),
                              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.power_off,
                                color: Colors.white,
                                size: 45,
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'bied3soc' /* Shutdown */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Coming soon',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              duration: Duration(milliseconds: 2000),
                              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 45,
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  '7a9edt5f' /* Restart */,
                                ),
                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Coming soon',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              duration: Duration(milliseconds: 2000),
                              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.nightlight_round,
                                color: Colors.white,
                                size: 45,
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'avu7ysio' /* Sleep */,
                                ),
                                style: FlutterFlowTheme.of(context).subtitle1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 50, 8, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'd2ke4olt' /* MAC Adress: */,
                                  ),
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: Text(
                                    widget.pc.mac,
                                    style: FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '7pqir15j' /* PC Name: */,
                                  ),
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: Text(
                                    name,
                                    style: FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.edit,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              final text = await showTextInputDialog(
                                context: context,
                                textFields: const [
                                  DialogTextField(
                                    hintText: '',
                                  ),
                                ],
                                title: FFLocalizations.of(context).getText(
                                  '7pqir15j' /* PC Name: */,
                                ),
                              );

                              updateName(text[0]);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'g2lrrb9y' /* IP Address: */,
                                  ),
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: Text(
                                    ip,
                                    style: FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.edit,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              final text = await showTextInputDialog(
                                context: context,
                                textFields: const [
                                  DialogTextField(
                                    hintText: '',
                                  ),
                                ],
                                title: FFLocalizations.of(context).getText(
                                  'g2lrrb9y' /* IP Address: */,
                                ),
                              );

                              updateIp(text[0]);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'ml43v9az' /* Port: */,
                                  ),
                                  style: FlutterFlowTheme.of(context).subtitle1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                                  child: Text(
                                    port,
                                    style: FlutterFlowTheme.of(context).subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: Icon(
                              Icons.edit,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              final text = await showTextInputDialog(
                                context: context,
                                textFields: const [
                                  DialogTextField(
                                    hintText: '',
                                  ),
                                ],
                                title: FFLocalizations.of(context).getText(
                                  'ml43v9az' /* Port */,
                                ),
                              );

                              updatePort(text[0]);
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 25),
                        child: FFButtonWidget(
                          onPressed: () async {
                            final confirmDialogResponse = await showModalActionSheet<String>(
                              context: context,
                              title: FFLocalizations.of(context).getText('afsadgfshghe'),
                              message: FFLocalizations.of(context).getText('owuehbnfiwbbubebbbsedf'),
                              cancelLabel: FFLocalizations.of(context).getText('uonfaasffsa'),
                              actions: [
                                SheetAction(
                                  icon: Icons.warning,
                                  label: FFLocalizations.of(context).getText('go5528js'),
                                  key: 'destructiveKey',
                                  isDestructiveAction: true,
                                ),
                              ],
                            );

                            if (confirmDialogResponse == 'destructiveKey') {
                              deletePc();

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePageWidget(),
                                ),
                              );
                            }
                          },
                          text: FFLocalizations.of(context).getText(
                            'go5528js' /* Delete */,
                          ),
                          icon: FaIcon(
                            FontAwesomeIcons.trash,
                            color: Colors.white,
                            size: 18,
                          ),
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: FlutterFlowTheme.of(context).alternate,
                            textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
