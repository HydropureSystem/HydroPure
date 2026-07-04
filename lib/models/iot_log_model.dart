class HydroponicLog {
  final double ph;
  final double tds;
  final double temperature;
  final DateTime timestamp;

  HydroponicLog({
    required this.ph,
    required this.tds,
    required this.temperature,
    required this.timestamp,
  });

  factory HydroponicLog.fromMap(Map<String, dynamic> map) {
    return HydroponicLog(
      ph: (map['ph'] ?? 0).toDouble(),
      tds: (map['tds'] ?? 0).toDouble(),
      temperature: (map['temperature'] ?? 0).toDouble(),
      timestamp: DateTime.parse(
        map['timestamp'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
