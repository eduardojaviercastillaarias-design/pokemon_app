import 'package:flutter/material.dart';
import '../../data/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8, 
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24.0), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 36, // Letra más grande
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), 
            Image.network(
              pokemon.imageUrl,
              height: 250, 
            ),
            const SizedBox(height: 20), 
            Text('ID: ${pokemon.id}', style: const TextStyle(fontSize: 20)),
            Text('Altura: ${pokemon.height}', style: const TextStyle(fontSize: 20)),
            Text('Peso: ${pokemon.weight}', style: const TextStyle(fontSize: 20)),
            Text('Tipo: ${pokemon.types.join(', ')}', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}