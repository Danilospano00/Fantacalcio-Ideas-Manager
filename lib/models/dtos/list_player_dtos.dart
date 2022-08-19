import 'player_dto.dart';

class ListPlayerDtos {
  List<PlayerDto>? list;
  final bool?b = true;
  ListPlayerDtos({
    this.list,
  });

  factory ListPlayerDtos.fromJson(List<Map<String, dynamic>> json) {
    List<PlayerDto> listPlayerDto = [];
    for (var player in json) {
      listPlayerDto.add(PlayerDto.fromJson(player));
    }
    return ListPlayerDtos(
      list: listPlayerDto,
    );
  }

  List<Map<String, dynamic>> toJson() {
    return [...?list?.map((e) => e.toJson()).toList()];
  }
}
