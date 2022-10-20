import 'dart:convert';

import 'package:healio/models/heart_disease_form_model.dart';
import 'package:http/http.dart' as http;

class HeartDiseaseService {
  String baseUrl = 'https://heartapi.herokuapp.com';

  Future<Map<String, dynamic>> prediction(HeartDiseaseFormModel data) async {
    var url = Uri.parse(
        '$baseUrl/predict?age=${data.age}&sex=${data.sex}&cigs=${data.cigs}&chol=${data.chol}&sBP=${data.sBP}&dia=${data.dia}&dBP=${data.dBP}&gluc=${data.gluc}&hRate=${data.hRate}');

    var res = await http.get(url);

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);

      return result;
    } else {
      throw Exception('Gagal memprediksi');
    }
  }
}
