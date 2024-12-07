import 'package:flutter/cupertino.dart';

class MatchDate extends ChangeNotifier {
  var datestore;

  storeDate(date) {
    datestore = date;
    notifyListeners();
  }
}
