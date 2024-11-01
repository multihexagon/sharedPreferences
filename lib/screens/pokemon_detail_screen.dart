import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers/pokemon_detail_provider.dart';

class PokemonDetailScreen extends ConsumerWidget {
  final String pokemonName;

  const PokemonDetailScreen({Key? key, required this.pokemonName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetailAsyncValue = ref.watch(pokemonDetailProvider(pokemonName));

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonName, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFD32F2F), // Pokedex red
      ),
      body: pokemonDetailAsyncValue.when(
        data: (data) {
          return SingleChildScrollView(
            child: Container(
              color: Color(0xFFEEEEEE), // Pokedex background gray
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sprite Image
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFFFD700), width: 3), // Pokedex yellow border
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Image.network(data['sprites']['front_default'], height: 150),
                    ),
                  ),
                  
                  // Basic Info Card
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Color(0xFFFFD700), width: 2), // Pokedex yellow border
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Color(0xFFD32F2F), // Pokedex red
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Text(
                              'Basic Info',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Name: ${data['name']}', style: TextStyle(fontSize: 18)),
                          Text('Height: ${data['height']} dm', style: TextStyle(fontSize: 18)),
                          Text('Weight: ${data['weight']} hg', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Color(0xFFFFD700), width: 2),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Color(0xFFD32F2F),
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Text(
                              'Stats',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          for (var stat in data['stats']) // Loop through stats
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${stat['stat']['name']}', style: TextStyle(fontSize: 18)),
                                  Text('${stat['base_stat']}', style: TextStyle(fontSize: 18, color: Color(0xFFD32F2F))),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Color(0xFFFFD700), width: 2),
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: Color(0xFFD32F2F),
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: Text(
                              'Abilities',
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 8),
                          for (var ability in data['abilities'])
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                ability['ability']['name'],
                                style: TextStyle(fontSize: 18, color: Colors.black87),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
