class Measurement {
  final String name;
  final List<double> data;
  const Measurement({required this.name, required this.data});
  factory Measurement.fromJson(Map<String, dynamic> json) {
    final List d = json['data'] ?? [];
    return Measurement(
      name: json['name'],
      data: d.map((e) => double.parse(e.toString())).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
    "name" : name,
    "data" : data,
  };

  @override
  String toString() => '{ "name" : $name, "data" : $data }';
}
