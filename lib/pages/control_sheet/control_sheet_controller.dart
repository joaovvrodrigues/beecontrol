import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/bee_hive.dart';
import 'package:beecontrol/models/report.dart';
import 'package:beecontrol/utils/constants.dart';
import 'package:hive/hive.dart';

class ControlSheetController {
  Report report = Report(hives: [], resume: []);
  Apiary apiary = Apiary(reports: []);
  bool lastReport = false;

  void initHives() {
    if (apiary.reports.isEmpty) {
      if (apiary.numHives > 0) {
        List<BeeHive> hives = [];
        for (var i = 0; i < apiary.numHives; i++) {
          hives.add(
              BeeHive(name: 'Colméia ${i + 1}', situation: [], production: []));
        }
        report.hives.addAll(hives);
      }
    } else {
      if (report.newReport) {
        for (var hive in report.hives) {
          hive.situation.clear();
          hive.situation.addAll(hive.production);
          hive.production.clear();
        }
      }
    }
  }

  void findLastReport() {
    if (apiary.reports.isNotEmpty) {
      Report last = apiary.reports.firstWhere((element) =>
          element.name == 'Ficha de Controle ${apiary.reports.length}');
      if (report.name == last.name) {
        lastReport = true;
      }
    }
  }

  void divideHive(num mother, {bool count = false}) {
    report.hives.add(BeeHive(
        name: 'Colméia ${report.hives.length + 1}',
        dateOrphan: DateTime.now(),
        motherHive: mother,
        orphan: true,
        situation: [],
        count: count,
        production: []));
    report.numHives = report.hives.length;
    apiary.numHives = report.hives.length;
    report.orphanBoxes++;
    apiary.orphanBoxes++;
  }

  void addHive() {
    report.hives.add(BeeHive(
        name: 'Colméia ${report.hives.length + 1}',
        situation: [],
        production: []));
    report.numHives = report.hives.length;
    apiary.numHives = report.hives.length;
  }

  void saveReport() {
    report.numHives = report.hives.length;
    apiary.lastVisit = report.date;
    int index = int.parse(report.name.substring(18));

    for (var hive in report.hives) {
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
