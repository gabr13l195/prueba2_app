import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/platillo.dart';

class GastronomiaScreen extends StatefulWidget {
  const GastronomiaScreen({super.key});

  @override
  State<GastronomiaScreen> createState() => _GastronomiaScreenState();
}

class _GastronomiaScreenState extends State<GastronomiaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nombreController = TextEditingController();
  final _ciudadController = TextEditingController();
  final supabase = Supabase.instance.client;

  Future<void> _guardarPlatillo() async {
    if (_formKey.currentState!.validate()) {
      try {
        final platillo = Platillo(
          id: _idController.text,
          nombre: _nombreController.text,
          ciudad: _ciudadController.text,
        );

        await supabase.from('platillos').insert(platillo.toJson());

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Platillo guardado exitosamente')),
          );
          _limpiarFormulario();
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al guardar: $error')),
          );
        }
      }
    }
  }

  void _limpiarFormulario() {
    _idController.clear();
    _nombreController.clear();
    _ciudadController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastronomía'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  labelText: 'ID del Platillo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Plato Típico',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del plato';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ciudadController,
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la ciudad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _guardarPlatillo,
                child: const Text('Guardar Platillo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _nombreController.dispose();
    _ciudadController.dispose();
    super.dispose();
  }
} 