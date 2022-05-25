import 'package:blinking_text/blinking_text.dart';
import 'package:c7_wake_on_lan/add_pc/add_pc_widget.dart';
import 'package:lan_scanner/lan_scanner.dart';
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

    networkAnalyzing();
  }

  void networkAnalyzing() async {
    final scanner = LanScanner();
    var wifiIP = await NetworkInfo().getWifiIP();

    subnet = ipToCSubnet(wifiIP);

    final stream = scanner.icmpScan(subnet, progressCallback: (progress) {
      setState(() => percentInt = progress);
      setState(() => percentTxt = (progress * 100).toInt().toString() + '%');

      if (progress == 1) {
        isSearching = false;
      }
    });

    stream.listen((HostModel device) {
      print("Found host: ${device.ip}");
      foundIps.add(device.ip);
    });
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
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  duration: const Duration(milliseconds: 250),
                                  reverseDuration: const Duration(milliseconds: 250),
                                  child: AddPcWidget(ip: host),
                                ),
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
