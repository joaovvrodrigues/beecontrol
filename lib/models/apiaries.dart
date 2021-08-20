// import 'package:beecontrol/models/apiary.dart';
// import 'package:flutter/foundation.dart';

// class Apiaries extends ChangeNotifier {
//   List<Apiary> apiaries = [];

//   int get length => apiaries.length;
//   bool get isEmpty => apiaries.isEmpty;
//   Apiary getApiary(index) => apiaries[index];

//   void addAll(List<Apiary> aux) {
//     for (var item in aux) {
//       apiaries.add(item);
//     }
//     notifyListeners();
//   }

//   void add(Apiary apiary) {
//     apiaries.add(apiary);
//     notifyListeners();
//   }

//   void update(Apiary apiary) {
//     apiaries.firstWhere((element) => element.id == apiary.id).updateProvider(apiary);
//     notifyListeners();
//   }

//   void remove(int id) {
//     apiaries.removeWhere((element) => element.id == id);
//     notifyListeners();
//   }
// }
