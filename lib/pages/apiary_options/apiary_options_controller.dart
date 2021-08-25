import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/bee_hive.dart';
import 'package:beecontrol/utils/constants.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class ApiaryOptionsController {
  int numHives = 0;
  var apiary = Apiary(reports: [], visits: 0, orphanBoxes: 0);
  var uuid = Uuid();

  void saveApiary() {
    Hive.box<Apiary>(CONSTANTS.box).put(apiary.id, apiary);
  }

  void deleteApiary() async {
    Hive.box<Apiary>(CONSTANTS.box).delete(apiary.id);
  }

  void createApiary() async {
    //TODO: auto add hives
    // if (numHives > 0) {
    //   List<BeeHive> hives = [];
    //   for (var i = 0; i < numHives; i++) {
    //     hives.add(
    //         BeeHive(name: 'Colméia ${i + 1}', situation: [], production: []));
    //   }
    //   apiary.hives.addAll(hives);
    // }
    apiary.numHives = numHives;
    apiary.id = uuid.v1();
    await Hive.box<Apiary>(CONSTANTS.box).put(apiary.id, apiary);
  }
}
