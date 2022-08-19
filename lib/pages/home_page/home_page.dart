import 'package:fantacalcio_project/pages/player_detail/player_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  static String route = '/homePage';
  @override
  final controller = Get.put(HomePageController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.showlistPlayerDtoSortedByRole.value == true;
              controller.sortPlayerByRole();
            },
            icon: const Icon(Icons.sort),
          ),
          GestureDetector(
            onTap: () {
              controller.showAllPlayers();
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Text(
                "Mostra tutti",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, playerIndex) => GestureDetector(
                        onTap: () {
                          Get.to(() => PlayerDetailPage(),
                              arguments: controller.listToShow[playerIndex]);
                        },
                        child: ListTile(
                          title: Text(controller.listToShow[playerIndex].name),
                          trailing: Text(controller.listToShow[playerIndex].role
                              .toUpperCase()),
                        ),
                      ),
                      itemCount: controller.listToShow.length,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.getNewPlayerAlertDialog();
                    },
                    child: const Text("Aggiungi giocatore"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.readFantacalcioMapFromStorage();
                    },
                    child: const Text("Leggi file"),
                  ),
                ],
              ),
      ),
    );
  }
}
