import 'dart:convert';
import 'dart:developer';
import 'package:fantacalcio_project/models/dtos/list_player_dtos.dart';
import 'package:fantacalcio_project/player_json.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/dtos/player_dto.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MapStorage {
  void setPlayerMap(List<PlayerDto>? listPlayerDtos) {
    SharedPreferences.getInstance().then((preferences) {
      String decode_option = jsonEncode(listPlayerDtos);
      preferences.setString('playerList2', decode_option);
      log("Map saved");
    });
  }

  List<PlayerDto>? getPlayerMap() {
    List<PlayerDto> list = [];
    SharedPreferences.getInstance().then((preferences) {
      if (preferences.containsKey('playerList2')) {
        dynamic playerList =
            jsonDecode(preferences.getString('playerList2') ?? '[]');
        if (playerList is! List) throw const FormatException();
        for (dynamic item in playerList) {
          if (item is! Map<String, dynamic>) continue;
          final player = PlayerDto.fromJson(item);
          list.add(player);
        }
      }
      return list;
    });
    return list;
  }
}
