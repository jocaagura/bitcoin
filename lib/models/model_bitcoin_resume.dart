class ModelBitcoin {
  ModelBitcoin({
    required this.bpi,
    required this.disclaimer,
    required this.time,
  });

  final Map<String, double> bpi;
  final String disclaimer;
  final Time time;

  factory ModelBitcoin.fromJson(Map<String, dynamic> json) => ModelBitcoin(
        bpi: Map.from(json["bpi"])
            .map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        disclaimer: json["disclaimer"],
        time: Time.fromJson(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "bpi": Map.from(bpi).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "disclaimer": disclaimer,
        "time": time.toJson(),
      };

  Map<String, double> returnAfterDate(DateTime dateTime) {
    final Map<String, double> result = <String, double>{};
    this.bpi.forEach((key, value) {
      final tmpDate = DateTime.tryParse(key);
      if (tmpDate?.isAfter(dateTime) ?? false) {
        result[key] = value;
      }
    });
    return result;
  }
}

class Time {
  Time({
    required this.updated,
    required this.updatedIso,
  });

  final String updated;
  final DateTime updatedIso;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        updated: json["updated"],
        updatedIso: DateTime.parse(json["updatedISO"]),
      );

  Map<String, dynamic> toJson() => {
        "updated": updated,
        "updatedISO": updatedIso.toIso8601String(),
      };
}
