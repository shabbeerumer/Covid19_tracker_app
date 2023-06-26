import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modals/WorldStatesModal.dart';
import 'Utilites/appurl.dart';

class States_Services {
  Future<WorldStatesModal> FeatchWorldStateRecords() async {
    final response = await http.get(Uri.parse(App_url.worldsatateapi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModal.fromJson(data);
    } else
      throw Exception('Error');
  }

  var data;
  Future<List<dynamic>> Countrieslistapi() async {
    final response = await http.get(Uri.parse(App_url.countrieslist));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else
      throw Exception('Error');
  }
}
