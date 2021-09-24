// 🌎 Project imports:
import '../../models/apiary.dart';
import '../../models/report.dart';

class ApiaryController {
  Apiary apiary = Apiary(reports: []);
  Report report = Report(resume: [], hives: []);

  int orderBy = 0;

  Report addReport() {
    if (apiary.reports.isEmpty) {
      return Report(
          date: DateTime.now(),
          name: 'Ficha de Controle ${apiary.reports.length + 1}',
          resume: [],
          newReport: true,
          hives: []);
    } else {
      Report lastReport = apiary.reports.firstWhere((element) =>
          element.name == 'Ficha de Controle ${apiary.reports.length}');
      Report aux = Report(
          date: DateTime.now(),
          name: 'Ficha de Controle ${apiary.reports.length + 1}',
          resume: [],
          newReport: true,
          hives: []);

      aux.hives.addAll(lastReport.hives);

      return aux;
    }
  }

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
