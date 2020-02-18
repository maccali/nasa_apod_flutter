import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../config/api.dart';

class ApiNasa {
  static final String _apiKey = Api.apiKey;
  static final String _apiBaseUrl = 'https://api.nasa.gov/planetary/apod?';

  static String _startDate = '&start_date=';
  static String _endDate = '&end_date=';

  static String _apiUrl = '';

  String get apiUrl => _apiUrl;
  DateTime get currentDate => _currentDate;

  static DateTime _currentDate = new DateTime.now();
  static DateFormat formatter = new DateFormat('yyyy-MM-dd');

  void getCurrentUrl() {
    endDate();
    startDate();
    updateApiUrl();
  }

  void updateApiUrl() {
    _apiUrl = _apiBaseUrl + 'api_key=' + _apiKey + _startDate + _endDate;
  }

  void endDate() {
    setEndDate(formatter.format(currentDate));
  }

  void startDate() {
    var subt = currentDate.subtract(new Duration(days: 2));
    setStartDate(formatter.format(subt));
  }

  void setEndDate(endDate) {
    _endDate = '&end_date=' + endDate;
  }

  void setCurrentDate(currentDate) {
    _currentDate = currentDate;
  }

  void setStartDate(startDate) {
    _startDate = '&start_date=' + startDate;
  }

  // apodList() async {

  //   // Seta os valores da data;
  //   getCurrentUrl();
  //   currentDate = currentDate.subtract(new Duration(days: 5));

  //   final res = await http.get(apiUrl);

  //   if (res.statusCode == 200) {
  //     var itemsStr = json.decode(res.body);
  //     print(itemsStr);
  //     return itemsStr;
  //   } else {
  //     throw ("some arbitrary error");
  //   }
  // }

  // DateTime _todayDate(){
  //   return new DateTime.now();
  // }
}
