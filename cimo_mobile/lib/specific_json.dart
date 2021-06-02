import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart';

class SpecificEstablishment {
  String ref_id;
  List data = [];
  SpecificEstablishment({required this.ref_id});
  Future<void> getSpec() async {
    Response response = await get(
        'http://192.168.254.131/cimo/web/general_api.php?eid=$ref_id');
    data = jsonDecode(response.body);
  }
}
