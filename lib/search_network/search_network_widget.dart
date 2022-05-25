import 'dart:io';

import 'package:blinking_text/blinking_text.dart';
import 'package:c7_wake_on_lan/add_pc/add_pc_widget.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SearchNetworkWidget extends StatefulWidget {
  const SearchNetworkWidget({Key key}) : super(key: key);

  @override
  _SearchNetworkWidgetState createState() => _SearchNetworkWidgetState();
}

class _SearchNetworkWidgetState extends State<SearchNetworkWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String percentTxt = '0%';
  double percentInt = 0.0;
  List<String> foundIps = [];
  var subnet;
  bool isSearching = true;

  @override
  void initState() {
    super.initState();

    scanNetwork();
  }

  Future<void> scanNetwork() async {
    await (NetworkInfo().getWifiIP()).then(
      (ip) async {
        final String subnet = ip.substring(0, ip.lastIndexOf('.'));
        const port = 9;
        for (var i = 0; i < 256; i++) {
          setState(() => percentInt = (0.0039 * i));
          setState(() => percentTxt = (0.39 * i).toInt().toString() + '%');

          String ip = '$subnet.$i';
          await Socket.connect(ip, port, timeout: Duration(milliseconds: 50)).then((socket) async {
            await InternetAddress(socket.address.address).reverse().then((value) {
              print(value.host);
              print(socket.address.address);

              foundIps.add(value.host);
            }).catchError((error) {
              print(socket.address.address);
              print('Error: $error');
            });
            socket.destroy();
          }).catchError((error) => null);
        }
      },
    );

    isSearching = false;
    print('Done');
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: isSearching,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            percent: percentInt,
                            radius: 60,
                            lineWidth: 24,
                            animation: false,
                            progressColor: FlutterFlowTheme.of(context).primaryColor,
                            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                            center: Text(
                              percentTxt,
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: BlinkText(
                            FFLocalizations.of(context).getText(
                              '0nfkq8eq' /* Searching Network */,
                            ),
                            style: FlutterFlowTheme.of(context).subtitle1,
                            duration: Duration(milliseconds: 800)),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: !isSearching,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '3135dyww' /* Found Devices */,
                    ),
                    style: FlutterFlowTheme.of(context).subtitle1,
                  ),
                ),
              ),
              Visibility(
                visible: !isSearching,
                child: Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final host = foundIps[index];

                        return Card(
                          child: ListTile(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AddPcWidget(ip: host);
                                }),
                              );
                            },
                            title: Text(host),
                          ),
                        );
                      },
                      itemCount: foundIps.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
