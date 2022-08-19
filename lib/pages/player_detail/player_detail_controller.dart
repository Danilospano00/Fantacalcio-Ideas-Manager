import 'package:fantacalcio_project/models/dtos/player_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PlayerDetailController extends GetxController {
  RxBool descriptionIsChanging = RxBool(false);
  RxBool nameIsChanging = RxBool(false);
  RxBool roleIsChanging = RxBool(false);
  RxBool percentageIsChanging = RxBool(false);
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController percentageTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> roleTextEditingController = GlobalKey<FormState>();

  TextEditingController descriptionTextEditingController =
      TextEditingController();

  void modifiedPlayerDescription(PlayerDto playerDto, String? newDescription) {
    playerDto.description = newDescription;
  }

  void modifiedPlayerName(PlayerDto playerDto, String name) {
    playerDto.name = name;
  }

  void modifiedPlayerRole(PlayerDto playerDto, String role) {
    playerDto.role = role;
  }

  void modifiedPlayerPercentage(PlayerDto playerDto, int? percentage) {
    playerDto.percentage = percentage;
  }
}
