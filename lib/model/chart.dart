class ChartData {
  final int year;
  final String month;
  final double ghi;
  final double temp;
  final double producao;

  ChartData(
      {required this.year,
      required this.month,
      required this.ghi,
      required this.temp,
      required this.producao});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      year: json['year'],
      month: json['month'],
      ghi: json['ghi'],
      temp: json['temp'],
      producao: json['producao'],
    );
  }
}
