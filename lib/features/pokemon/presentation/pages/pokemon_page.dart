import 'package:flutter/material.dart';
import '../../data/models/pokemon.dart';
import '../../data/services/pokemon_service.dart';
import '../widgets/pokemon_card.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final PokemonService _pokemonService = PokemonService();
  final TextEditingController _controller = TextEditingController();

  Pokemon? pokemon;
  bool loading = false;
  String? error;

  Future<void> buscarPokemon() async {
    final nameOrId = _controller.text.trim();

    if (nameOrId.isEmpty) {
      setState(() {
        error = 'Por favor, escribe el nombre o ID de un Pokemon.';
        pokemon = null;
      });
      return;
    }

    setState(() {
      loading = true;
      error = null;
      pokemon = null;
    });

    try {
      final resultado = await _pokemonService.getPokemon(nameOrId);

      setState(() {
        pokemon = resultado;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString().replaceFirst('Exception: ', '');
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeAPI'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Buscar Pokemon',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre o ID',
                hintText: 'Ejemplo: pikachu o 25',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => buscarPokemon(),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : buscarPokemon,
                child: const Text('Buscar Pokemon'),
              ),
            ),
            const SizedBox(height: 25),
            if (loading)
              const CircularProgressIndicator(),
            
            if (error != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        error!,
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            if (pokemon != null)
              Expanded(
                child: SingleChildScrollView(
                  child: PokemonCard(
                    pokemon: pokemon!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}