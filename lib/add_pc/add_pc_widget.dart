import 'dart:convert';

import 'package:c7_wake_on_lan/model/model_pc.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../home_page/home_page_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class AddPcWidget extends StatefulWidget {
  const AddPcWidget({Key key, this.data}) : super(key: key);

  final List<String> data;

  @override
  _AddPcWidgetState createState() => _AddPcWidgetState();
}

class _AddPcWidgetState extends State<AddPcWidget> {
  TextEditingController textControllerName;
  TextEditingController textControllerMac;
  TextEditingController textControllerIp;
  TextEditingController textControllerPort;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textControllerName = TextEditingController();
    textControllerMac = TextEditingController();
    textControllerIp = TextEditingController();
    textControllerPort = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data[0] != FFLocalizations.of(context).getText('weifbuew')) {
      textControllerIp.text = widget.data[0];
      textControllerName.text = widget.data[1];
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    '9urjz9rj' /* Add a PC */,
                  ),
                  style: FlutterFlowTheme.of(context).title1,
                ),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextFormField(
                        controller: textControllerName,
                        onChanged: (_) => EasyDebounce.debounce(
                          'textController1',
                          Duration(milliseconds: 2000),
                          () => setState(() {}),
                        ),
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: FFLocalizations.of(context).getText(
                            'ep5gbmfs' /* PC Name */,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return FFLocalizations.of(context).getText(
                              'wxw0kag1' /* Field is required */,
                            );
                          }
                          if (val.length < 3) {
                            return FFLocalizations.of(context).getText(
                              'r4gvx61c' /* Min. 3 Characters */,
                            );
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: textControllerMac,
                          onChanged: (_) => EasyDebounce.debounce(
                            'textController2',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'iir0hzqn' /* MAC Address */,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return FFLocalizations.of(context).getText(
                                'wxw0kag1' /* Field is required */,
                              );
                            }

                            textControllerMac.text = textControllerMac.text.replaceAll('-', ':');

                            if (!MACAddress.validate(val)) {
                              return FFLocalizations.of(context).getText(
                                'pqownfdw' /* MAC invalid */,
                              );
                            }

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: textControllerIp,
                          onChanged: (_) => EasyDebounce.debounce(
                            'textController3',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'o2n760uf' /* IP Address */,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return FFLocalizations.of(context).getText(
                                'wxw0kag1' /* Field is required */,
                              );
                            }

                            if (!IPv4Address.validate(val)) {
                              return FFLocalizations.of(context).getText(
                                'cn09qewf' /* IP invalid */,
                              );
                            }

                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: TextFormField(
                          controller: textControllerPort,
                          onChanged: (_) => EasyDebounce.debounce(
                            'textController4',
                            Duration(milliseconds: 2000),
                            () => setState(() {}),
                          ),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'wvrblzc7' /* Port */,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return FFLocalizations.of(context).getText(
                                'xzr4qcs7' /* Field is required */,
                              );
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    if (formKey.currentState == null || !formKey.currentState.validate()) {
                      return;
                    }

                    //save pc to storage

                    String entries = FFAppState().pcEntries;
                    List<dynamic> list = [];
                    if (entries != null) {
                      list = jsonDecode(entries);
                    }

                    var pc = {
                      'name': textControllerName.text,
                      'mac': textControllerMac.text,
                      'ip': textControllerIp.text,
                      'port': textControllerPort.text,
                    };

                    bool exists = false;
                    for (var i = 0; i < list.length; i++) {
                      if (list[i]['mac'] == pc['mac']) {
                        // mac already exists
                        exists = true;
                      }
                    }

                    if (!exists) {
                      list.add(pc);

                      // TODO: make an error message because of existing mac address
                    }

                    String entriesNew = jsonEncode(list);
                    FFAppState().pcEntries = entriesNew;
                    FFAppState().hasEntry = true;

                    for (var i = 0; i < list.length; i++) {
                      PcModel pc = PcModel.fromJson(list[i]);
                      FFAppState().pcList.add(pc);
                    }

                    await Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.topToBottom,
                        duration: Duration(milliseconds: 300),
                        reverseDuration: Duration(milliseconds: 300),
                        child: HomePageWidget(),
                      ),
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'a0u6v4zo' /* Add */,
                  ),
                  options: FFButtonOptions(
                    width: 130,
                    height: 40,
                    color: FlutterFlowTheme.of(context).primaryColor,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
