import '../config/api.dart';

class ApiNasa {
  static final String _apiKey = Api.apiKey;
  static final String _apiBaseUrl = 'https://api.nasa.gov/planetary/apod?';

  static String _startDate = '&start_date=';
  static String _endDate = '&end_date=';

  static final String _apiUrl =
      _apiBaseUrl + 'api_key=' + _apiKey + _startDate + _endDate;

      

  String get apiUrl => _apiUrl;

  String get endDate => _endDate;
  set endDate(value) => _endDate = '&end_date=' + value;

  String get startDate => _startDate;
  set startDate(value) => _startDate = '&start_date=' + value;
}
