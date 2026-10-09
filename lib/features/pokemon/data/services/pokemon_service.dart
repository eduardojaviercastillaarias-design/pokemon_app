import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<Pokemon> getPokemon(String nameOrId) async {
    final url = Uri.parse('$baseUrl/$nameOrId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return Pokemon.fromJson(jsonMap);
    } else if (response.statusCode == 404) {
      throw Exception('No se encontro el Pokemon solicitado.');
    } else {
      throw Exception(
        'Error al consultar la API. Codigo: ${response.statusCode}',
      );
    }
  }
}