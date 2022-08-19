import '../../models/dtos/player_dto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'player_detail_controller.dart';

class PlayerDetailPage extends GetView<PlayerDetailController> {
  static String route = '/playerDetail';
  @override
  final controller = Get.put(PlayerDetailController());

  PlayerDto player = Get.arguments;

  PlayerDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    controller.nameIsChanging.value
                        ? Column(
                            children: [
                              TextFormField(
                                controller: controller.nameTextEditingController
                                  ..value = TextEditingValue(
                                    text: player.name,
                                  ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.nameIsChanging.value = false;
                                  },
                                  child: const Text("ANNULLA")),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.modifiedPlayerName(
                                      player,
                                      controller.nameTextEditingController.text,
                                    );
                                    controller.nameIsChanging.value = false;
                                  },
                                  child: const Text("CONFERMA")),
                            ],
                          )
                        : Row(
                            children: [
                              Text(player.name.toUpperCase()),
                              IconButton(
                                  onPressed: () {
                                    controller.nameIsChanging.value = true;
                                  },
                                  icon: const Icon(Icons.mode)),
                            ],
                          ),
                    controller.roleIsChanging.value == true
                        ? Column(
                            children: [
                              Form(
                                key: controller.roleTextEditingController,
                                child: DropdownButtonFormField<String>(
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
                                  onSaved: (role) {
                                    controller.modifiedPlayerRole(
                                        player, role ?? '');
                                    controller.roleIsChanging.value = false;
                                  },
                                  validator: (role) {
                                    if (role?.isEmpty == true) {
                                      return 'Inserisci ruolo';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      label: Text("Ruolo")),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.roleIsChanging.value = false;
                                  },
                                  child: const Text("ANNULLA")),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.roleTextEditingController.currentState?.save();
                                  },
                                  child: const Text("CONFERMA")),
                            ],
                          )
                        : Row(
                            children: [
                              Text(player.role),
                              IconButton(
                                  onPressed: () {
                                    controller.roleIsChanging.value = true;
                                  },
                                  icon: const Icon(Icons.mode)),
                            ],
                          ),
                    Row(
                      children: [
                        Text('Percentuale: ${player.percentage}%'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Valore in crediti: ${player.percentage}%'),
                      ],
                    ),
                    controller.descriptionIsChanging.value
                        ? Column(
                            children: [
                              TextFormField(
                                minLines: 3,
                                maxLines: 10,
                                controller:
                                    controller.descriptionTextEditingController
                                      ..value = TextEditingValue(
                                        text: player.description ?? '',
                                      ),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.descriptionIsChanging.value =
                                        false;
                                  },
                                  child: const Text("ANNULLA")),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.modifiedPlayerDescription(
                                      player,
                                      controller
                                          .descriptionTextEditingController
                                          .text,
                                    );
                                    controller.descriptionIsChanging.value =
                                        false;
                                  },
                                  child: const Text("CONFERMA")),
                            ],
                          )
                        : Row(
                            children: [
                              Flexible(child: Text(player.description ?? '')),
                              IconButton(
                                  onPressed: () {
                                    controller.descriptionIsChanging.value =
                                        true;
                                  },
                                  icon: const Icon(Icons.mode)),
                            ],
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
