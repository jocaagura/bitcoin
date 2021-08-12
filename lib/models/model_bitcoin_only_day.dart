class ModelBitcoinOnlyDay {
  ModelBitcoinOnlyDay({
    required this.time,
    required this.disclaimer,
    required this.bpi,
  });

  final Time time;
  final String disclaimer;
  final Map<String, Bpi> bpi;

  factory ModelBitcoinOnlyDay.fromJson(Map<String, dynamic> json) => ModelBitcoinOnlyDay(
    time: Time.fromJson(json["time"]),
    disclaimer: json["disclaimer"],
    bpi: Map.from(json["bpi"]).map((k, v) => MapEntry<String, Bpi>(k, Bpi.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "time": time.toJson(),
    "disclaimer": disclaimer,
    "bpi": Map.from(bpi).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Bpi {
  Bpi({
    required this.code,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });

  final String code;
  final String rate;
  final String description;
  final double rateFloat;

  factory Bpi.fromJson(Map<String, dynamic> json) => Bpi(
    code: json["code"],
    rate: json["rate"],
    description: json["description"],
    rateFloat: json["rate_float"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "rate": rate,
    "description": description,
    "rate_float": rateFloat,
  };
}

class Time {
  Time({
    required this.updated,
    required this.updatedIso,
    required this.updateduk,
  });

  final String updated;
  final DateTime updatedIso;
  final String updateduk;

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    updated: json["updated"],
    updatedIso: DateTime.parse(json["updatedISO"]),
    updateduk: json["updateduk"],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated,
    "updatedISO": updatedIso.toIso8601String(),
    "updateduk": updateduk,
  };
}
