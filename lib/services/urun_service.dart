import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:favoriler_sayfasi/models/urun.dart';

class UrunService {
  Future<List<Urun>> tumUrunleriGetir() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => Urun.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      return []; 
    }
  }
}