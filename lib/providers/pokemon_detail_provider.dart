import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final pokemonDetailProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, pokemonName) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load Pokémon details');
  }
});
