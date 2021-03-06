import 'package:http/http.dart' as http;

class Repository {
  String _baseUrl = 'https://casingapik.com/api';

  var _headers = {
    "Content-type": "application/x-www-form-urlencoded",
    "Accept": "application/json"
  };

  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api);
  }

  httpGetById(String api, categoryId) async {
    return await http.get(_baseUrl + "/" + api + "/" + categoryId.toString());
  }

  httpPost(String api, data) async {
    return await http.post(_baseUrl + "/" + api, body: data, headers: _headers);
  }
}
