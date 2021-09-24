// 📦 Package imports:
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

// 🌎 Project imports:
import '../../models/apiary.dart';
import '../../utils/constants.dart';

class ApiaryOptionsController {
  int numHives = 0;
  var apiary = Apiary(reports: [], visits: 0, orphanBoxes: 0);
  var uuid = const Uuid();

  void saveApiary() {
    Hive.box<Apiary>(CONSTANTS.box).put(apiary.id, apiary);
  }

  void deleteApiary() async {
    Hive.box<Apiary>(CONSTANTS.box).delete(apiary.id);
  }

  void createApiary() async {
    apiary.numHives = numHives;
    apiary.id = uuid.v1();
    await Hive.box<Apiary>(CONSTANTS.box).put(apiary.id, apiary);
  }
}
