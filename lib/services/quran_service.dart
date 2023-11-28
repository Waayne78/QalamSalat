import 'dart:convert';
import 'package:http/http.dart' as http;

class QuranService {
  static const String baseUrl = 'https://api.quran.com/v1';

  static Future<List<Map<String, dynamic>>> fetchVerses(int surahNumber) async {
    final apiUrl = '$baseUrl/surahs/$surahNumber/verses';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load verses');
    }
  }
}
