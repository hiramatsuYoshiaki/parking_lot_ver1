class Room {
  final String name;
  final String building;
  final int floor;
  final String floorPlan;
  final int rent;
  final bool used;
  final bool exist;
  final DateTime? createdAt;
  final DateTime? updateAt;
  Room({
    required this.name,
    required this.building,
    required this.floor,
    required this.floorPlan,
    required this.rent,
    required this.used,
    required this.exist,
    required this.createdAt,
    required this.updateAt,
  });
}
