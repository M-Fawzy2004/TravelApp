class GovernorateModel {
  final bool success;
  final Map<String, Datum> data;

  GovernorateModel({
    required this.success,
    required this.data,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      GovernorateModel(
        success: json["success"] as bool? ?? false,
        data: json["data"] != null
            ? Map.from(json["data"]).map(
                (k, v) => MapEntry<String, Datum>(
                  k,
                  Datum.fromJson(v),
                ),
              )
            : {},
      );
}

class Datum {
  final String namegovernorate;
  final List<Station> stations;

  Datum({
    required this.namegovernorate,
    required this.stations,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        namegovernorate: json["namegovernorate"] as String? ?? '',
        stations: json["stations"] != null
            ? List<Station>.from(
                json["stations"].map(
                  (x) => Station.fromJson(x),
                ),
              )
            : [],
      );
}

class Station {
  final String name;
  final List<RouteModel> routes;

  Station({
    required this.name,
    required this.routes,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        name: json["name"] as String? ?? '',
        routes: json["routes"] != null
            ? List<RouteModel>.from(
                json["routes"].map(
                  (x) => RouteModel.fromJson(x),
                ),
              )
            : [],
      );
}

class RouteModel {
  final String destination;
  final int price;
  final String duration;

  RouteModel({
    required this.destination,
    required this.price,
    required this.duration,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        destination: json["destination"] as String? ?? '',
        price: json["price"] as int? ?? 0,
        duration: json["duration"] as String? ?? '',
      );
}
