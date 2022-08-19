import 'dart:developer';

import 'package:fantacalcio_project/global_utils/access_storage.dart';
import 'package:fantacalcio_project/global_utils/map_storage.dart';
import 'package:fantacalcio_project/models/dtos/player_dto.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomePageController extends GetxController {
  RxBool isLoading = RxBool(true);
  RxList<PlayerDto> listToShow = RxList([]);
  RxList<PlayerDto> listOfAllPlayerDto = RxList([]);
  MapStorage mapStorage = MapStorage();

  RxBool showlistPlayerDtoSortedByRole = RxBool(false);
  RxList<PlayerDto> listPlayerDtoSortedByRole = RxList([]);

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  PlayerDto playerDto = PlayerDto(role: '', name: '');

  @override
  void onInit() {
    if (AccessStorage.getFirstAccessValue()) {
      mapStorage.setPlayerMap(listOfAllPlayerDto);
      AccessStorage.setFirstAccess();
    }
    mapStorage.getPlayerMap();
    listToShow.addAll(mapStorage.getPlayerMap() ?? []);
    isLoading.value = false;
    super.onInit();
  }

  void readFantacalcioMapFromStorage() {
    log('${mapStorage.getPlayerMap()}');
  }

  List<PlayerDto>? createPlayerList(List<PlayerDto>? playerList) {
    listToShow.value = playerList ?? [];
    listOfAllPlayerDto.addAll(listToShow);
    orderPlayerListByName();
    mapStorage.setPlayerMap(playerList);
  }

  void createNewPlayer({
    String? name,
    String? description,
    int? percentage,
    String? role,
  }) {
    playerDto.name = name ?? playerDto.name;
    playerDto.description = description ?? playerDto.description;
    playerDto.role = role ?? playerDto.role;
    playerDto.percentage = percentage ?? playerDto.percentage;
  }

  void addPlayerToList() {
    if (globalKey.currentState?.validate() == true) {
      PlayerDto newPlayerDto = PlayerDto(
          name: playerDto.name,
          role: playerDto.role,
          description: playerDto.description,
          percentage: playerDto.percentage);
      listOfAllPlayerDto.add(newPlayerDto);
      mapStorage.setPlayerMap(listOfAllPlayerDto.value);
      showAllPlayers();
      log('New player added');
      Get.back();
    }
  }

  void showAllPlayers() {
    listToShow.clear();
    listToShow.addAll(listOfAllPlayerDto);
  }

  void orderPlayerListByName() {
    listToShow.sort((a, b) => a.name.compareTo(b.name));
  }

  void sortPlayerByRole() {
    listPlayerDtoSortedByRole.value =
        listToShow.where((p) => p.role == 'a').toList();
    listToShow.clear();
    listToShow.addAll(listPlayerDtoSortedByRole);
    orderPlayerListByName();
  }

  void getNewPlayerAlertDialog() {
    Get.dialog(AlertDialog(
      actions: [
        ElevatedButton(
            onPressed: () => Get.back(), child: const Text("Annulla")),
        ElevatedButton(
          onPressed: () {
            globalKey.currentState?.save();
            addPlayerToList();
            orderPlayerListByName();
          },
          child: const Text("Conferma"),
        ),
      ],
      content: Column(
        children: [
          Form(
            key: globalKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (name) {
                    if (name?.isEmpty == true) {
                      return 'Inserisci nome';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(label: Text("Nome")),
                  onSaved: (name) => createNewPlayer(name: name),
                ),
                TextFormField(
                  onSaved: (percentage) {
                    if (percentage?.isNotEmpty == true) {
                      createNewPlayer(percentage: int.parse(percentage ?? ''));
                    } else {
                      createNewPlayer(percentage: 0);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Percentuale"),
                  ),
                ),
                DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem<String>(
                      child: Text("Portiere"),
                      value: 'portiere',
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Difensore"),
                      value: 'difensore',
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Centrocampista"),
                      value: 'centrocampista',
                    ),
                    DropdownMenuItem<String>(
                      child: Text("Attaccante"),
                      value: 'attaccante',
                    ),
                  ],
                  onChanged: (value) {},
                  onSaved: (role) => createNewPlayer(role: role),
                  validator: (role) {
                    if (role?.isEmpty == true) {
                      return 'Inserisci ruolo';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(label: Text("Ruolo")),
                ),
                TextFormField(
                  onSaved: (description) =>
                      createNewPlayer(description: description),
                  decoration: const InputDecoration(
                    label: Text("Descrizione"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}
