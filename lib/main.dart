import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/home_page/home_page.dart';
import 'pages/player_detail/player_detail_page.dart';

void main() async {
  await GetStorage.init();
  return runApp(GetMaterialApp(
    home: HomePage(),
    getPages: [
      GetPage(name: HomePage.route, page: () => HomePage()),
      GetPage(name: PlayerDetailPage.route, page: () => PlayerDetailPage()),
    ],
  ));
}
