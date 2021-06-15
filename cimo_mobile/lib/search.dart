import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';

class SearchEstablishment {
  // ignore: non_constant_identifier_names
  String search;
  List data = [];
  // ignore: non_constant_identifier_names
  SearchEstablishment({required this.search});
  Future<void> getsearch() async {
    if (search == "") {
      Response response =
          await get('http://192.168.254.131/cimo/web/general_api.php?all');
      data = jsonDecode(response.body);
    } else {
      Response response = await get(
          'http://192.168.254.131/cimo/web/general_api.php?search=$search');
      data = jsonDecode(response.body);
    }
  }
}
