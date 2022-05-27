import 'dart:convert';

import 'package:c7_wake_on_lan/detail/detail_widget.dart';
import 'package:c7_wake_on_lan/model/model_pc.dart';
import 'package:c7_wake_on_lan/search_network/search_network_widget.dart';
import 'package:c7_wake_on_lan/settings/settings_widget.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<PcModel> pcList = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      String entries = FFAppState().pcEntries;
      if (entries != null && entries.isNotEmpty) {
        List<dynamic> pcArr = jsonDecode(entries);

        for (var i = 0; i < pcArr.length; i++) {
          PcModel pc = PcModel.fromJson(pcArr[i]);
          pcList.add(pc);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'WaLa',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 22,
              ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.add,
              color: FlutterFlowTheme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchNetworkWidget(),
                ),
              );
            },
          ),
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.settings,
              color: FlutterFlowTheme.of(context).primaryColor,
              size: 30,
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsWidget(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              getList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getList() {
    if (FFAppState().hasEntry) {
      return Expanded(
        child: Builder(
          builder: (context) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: pcList.length,
              itemBuilder: (context, i) {
                final pcsItem = pcList[i];

                return ListTile(
                  leading: Icon(
                    Icons.computer,
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                  title: Text(
                    pcsItem.name,
                    style: FlutterFlowTheme.of(context).title3,
                  ),
                  subtitle: Text(
                    pcsItem.ip,
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    size: 20,
                  ),
                  tileColor: FlutterFlowTheme.of(context).primaryBackground,
                  dense: false,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DetailWidget(pc: pcsItem);
                      }),
                    );
                  },
                );
              },
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
        child: Text(
          'No PC added yet. Press the button in the upper right to add your first PC',
          style: FlutterFlowTheme.of(context).subtitle1,
        ),
      );
    }
  }
}
