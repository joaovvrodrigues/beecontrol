import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/bee_hive.dart';
import 'package:beecontrol/models/report.dart';
import 'package:beecontrol/utils/constants.dart';
import 'package:hive/hive.dart';

class ControlSheetController {
  Report report = Report(resume: []);
  Apiary apiary = Apiary(hives: [], reports: []);

  void addHive() {
    apiary.hives.add(BeeHive(
        name: 'Colméia ${apiary.hives.length + 1}',
        situation: [],
        production: []));
    report.numHives = apiary.hives.length;
  }

  void saveReport() {
    report.numHives = apiary.hives.length;
    apiary.lastVisit = report.date;
    int index = int.parse(report.name.substring(18));

    for (var hive in apiary.hives) {
      hive.production.removeWhere((element) => element == 'null');
    }

    if (apiary.reports.length >= index) {
      apiary.reports[apiary.reports
          .indexWhere((element) => element.date == report.date)] = report;
    } else {
      apiary.reports.add(report);
    }

    apiary.visits = apiary.reports.length;

    Hive.box<Apiary>(CONSTANTS.box).put(apiary.id, apiary);
  }
}
