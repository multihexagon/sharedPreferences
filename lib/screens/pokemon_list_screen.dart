import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/data_provider.dart';
import 'package:myapp/screens/pokemon_detail_screen.dart';

class PokemonListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsyncValue = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
        backgroundColor: Color(0xFFD32F2F), // Pokedex red
      ),
      body: dataAsyncValue.when(
        data: (data) {
          final pokemonList = data['results'] as List;

          return Container(
            color: Color(0xFFEEEEEE), // Pokedex background gray
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];
                
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(0xFFFFD700), width: 2), // Pokedex yellow border
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFD32F2F), // Pokedex red for the circle background
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8),
                      child: Text(
                        '#${index + 1}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      pokemon['name'].toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD32F2F),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward, color: Color(0xFFFFD700)), // Pokedex yellow icon
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailScreen(pokemonName: pokemon['name']),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
