import '../player.dart';

class PlayerDto {
  String name;
  String? description;
  int? percentage;
  String role;

  PlayerDto({
    required this.name,
    this.description,
    this.percentage,
    required this.role,
  });

  factory PlayerDto.fromJson(Map<String, dynamic> json) {
    return PlayerDto(
      name: json["name"] ?? '',
      description: json["description"]?? '',
      percentage: json["percentage"] ?? '',
      role: json["role"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'percentage': percentage,
      'role': role,
    };
  }

  Player toModel(PlayerDto playerDto) {
    return Player(
      name: playerDto.name,
      description: playerDto.description,
      percentage: playerDto.percentage,
      role: playerDto.role,
    );
  }
}
