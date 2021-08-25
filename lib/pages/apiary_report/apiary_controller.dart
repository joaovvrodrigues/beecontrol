import 'package:beecontrol/models/apiary.dart';
import 'package:beecontrol/models/report.dart';

class ApiaryController {
  Apiary apiary = Apiary(reports: []);
  Report report = Report(resume: [], hives: []);
  int orderBy = 0;
  List<String> orderByList = [
    'Data (Decrescente)',
    'Data (Crescente)',
  ];

  void sortList(text) {
    switch (orderByList.indexOf(text!)) {
      case 0:
        apiary.reports.sort((a, b) => -a.date!.compareTo(b.date!));
        break;
      case 1:
        apiary.reports.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
    }
  }
}
