import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/summary.dart';

class ApiariesController {
  Summary summary =
      Summary(numApiaries: 0, numHives: 0, numReports: 0, orphanBoxes: 0);

  List<Apiary> searchApiaries = [];
  List<Apiary> apiaries = [];

  void create(Apiary apiary) {
    apiaries.add(apiary);
  }

  void search(String text) {
    searchApiaries.clear();
    for (var apiary in apiaries) {
      if (apiary.name.toLowerCase().contains(text.toLowerCase())) {
        searchApiaries.add(apiary);
      }
    }
  }

  void clear() {
    searchApiaries.clear();
  }

  void initSummary() {
    summary =
        Summary(numApiaries: 0, numHives: 0, numReports: 0, orphanBoxes: 0);

    summary.numApiaries = apiaries.length;
    for (var apiary in apiaries) {
      summary.orphanBoxes += apiary.orphanBoxes;
      summary.numReports += apiary.reports.length;
      summary.numHives += apiary.hives.length;
    }
  }
}
