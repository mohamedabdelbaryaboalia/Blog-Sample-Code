import 'package:homeward_interview_sample_code/services/utils/constants.dart';
import 'package:http/http.dart' as http;

class Api {
  final http.Client _client = http.Client();
  final String _url = Constants.mainUrl;
  static final Api _api = Api._internal();

  Api._internal();

  factory Api.call() {
    return _api;
  }

  http.Client client() {
    return _client;
  }

  String url() {
    return _url;
  }

  void closeClient() {
    _client.close();
  }
}
