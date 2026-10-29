class Vehicle {
  final String type;
  final String? licensePlate;

  Vehicle({
    required this.type,
    this.licensePlate,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'licensePlate': licensePlate,
    };
  }
}