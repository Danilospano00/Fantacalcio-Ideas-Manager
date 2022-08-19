import 'package:get_storage/get_storage.dart';

class AccessStorage {

  static void setFirstAccess() {
    final box = GetStorage();
    box.write('firtAccess', false);
  }

  static bool getFirstAccessValue() {
    final box = GetStorage();
    return box.hasData('firtAccess') ? box.read('firtAccess') : true;
  }
}
