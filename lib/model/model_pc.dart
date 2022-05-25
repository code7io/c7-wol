class PcModel {
  final String name;
  final String mac;
  final String ip;
  final String port;

  const PcModel({this.name, this.mac, this.ip, this.port});

  factory PcModel.fromJson(Map<String, dynamic> json) {
    return PcModel(
      name: json['name'],
      mac: json['mac'],
      ip: json['ip'],
      port: json['port'],
    );
  }
}
