import 'dart:io';

import 'package:blinking_text/blinking_text.dart';
import 'package:c7_wake_on_lan/add_pc/add_pc_widget.dart';
import 'package:c7_wake_on_lan/flutter_flow/flutter_flow_icon_button.dart';
import 'package:c7_wake_on_lan/home_page/home_page_widget.dart';
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
  List<List<String>> foundIps = [];
  var subnet;
  bool isSearching = true;
  int blinkDuration = 800;
  String title = '0nfkq8eq';
  int pingTime = 100;

  @override
  void initState() {
    super.initState();
    setState(() {
      pingTime = FFAppState().pingTime;
    });

    scanNetwork();
  }

  Future<void> scanNetwork() async {
    await (NetworkInfo().getWifiIP()).then(
      (ip) async {
        final String subnet = ip.substring(0, ip.lastIndexOf('.'));
        const port = 22;
        for (var i = 0; i < 256; i++) {
          setState(() => percentInt = (0.0039 * i));
          setState(() => percentTxt = (0.39 * i).toInt().toString() + '%');

          String ip = '$subnet.$i';
          await Socket.connect(ip, port, timeout: Duration(milliseconds: pingTime)).then((socket) async {
            await InternetAddress(socket.address.address).reverse().then((value) {
              foundIps.add([value.host, value.address]);
            }).catchError((error) {
              print(socket.address.address);
              print('Error: $error');
            });
            socket.destroy();
          }).catchError((error) => null);
        }
      },
    );

    if (foundIps.length == 0) {
      foundIps.add(['weifbuew']);
    }

    setState(() => isSearching = false);
    setState(() => blinkDuration = 1);
    setState(() => title = '3135dyww');
    print('Done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isSearching,
              child: BlinkText(FFLocalizations.of(context).getText(title), style: FlutterFlowTheme.of(context).subtitle1, duration: Duration(milliseconds: blinkDuration)),
            ),
            Visibility(
              visible: !isSearching,
              child: Text(FFLocalizations.of(context).getText(title), style: FlutterFlowTheme.of(context).subtitle1),
            ),
          ],
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.close,
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
                            radius: 90,
                            lineWidth: 24,
                            animation: false,
                            progressColor: FlutterFlowTheme.of(context).primaryColor,
                            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                            center: Text(
                              percentTxt,
                              style: FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 26,
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                        var host = foundIps[index];

                        if (host[0] == 'weifbuew') {
                          host[0] = FFLocalizations.of(context).getText(
                            'weifbuew' /* no result */,
                          );
                        }

                        return Card(
                          child: ListTile(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AddPcWidget(data: host);
                                }),
                              );
                            },
                            title: Text(host[0]),
                            subtitle: Text(host[1]),
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
