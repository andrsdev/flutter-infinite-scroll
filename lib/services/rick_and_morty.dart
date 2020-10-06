import 'dart:async';
import 'dart:convert';
import 'package:infinite_scroll/models/Character.dart';
import 'package:http/http.dart' as http;

class RickAndMortyService {
  String api = "https://rickandmortyapi.com/api/character";

  Future<List<Character>> getCharacters(int page) async {
    http.Response response = await http.get("$api/?page=$page");
    List<dynamic> results = json.decode(response.body)['results'];
    return results.map((data) => Character.fromMap(data)).toList();
  }
}
