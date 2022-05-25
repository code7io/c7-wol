import 'package:c7_wake_on_lan/detail/detail_widget.dart';
import 'package:c7_wake_on_lan/search_network/search_network_widget.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 50),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WaLa',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: SearchNetworkWidget(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
            final pcs = FFAppState().pcList ?? [];
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: pcs.length,
              itemBuilder: (context, pcsIndex) {
                final pcsItem = pcs[pcsIndex];
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
