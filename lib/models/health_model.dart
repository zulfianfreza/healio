class HealthModel {
  final String type;
  final int value;
  final String unit;
  final String dateFrom;

  HealthModel({
    required this.type,
    required this.value,
    required this.unit,
    required this.dateFrom,
  });

  factory HealthModel.fromJson(Map<String, dynamic> json) => HealthModel(
        type: json['type'],
        value: json['value'],
        unit: json['unit'],
        dateFrom: json['dateFrom'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
        'unit': unit,
        'dateFrom': dateFrom,
      };
}
