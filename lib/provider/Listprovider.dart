import 'package:flutter/cupertino.dart';

class ListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _list = [];
  List<Map<String, dynamic>> getlist() => _list;

  void add(Map<String, dynamic> data) {
    _list.add(data);
    notifyListeners();
  }
}
