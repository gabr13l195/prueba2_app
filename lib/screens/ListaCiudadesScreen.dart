import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ciudad.dart';

class ListaCiudadesScreen extends StatefulWidget {
  const ListaCiudadesScreen({super.key});

  @override
  State<ListaCiudadesScreen> createState() => _ListaCiudadesScreenState();
}

class _ListaCiudadesScreenState extends State<ListaCiudadesScreen> {
  List<Ciudad> ciudades = [];
  bool isLoading = true;

  // URLs de ejemplo para las imágenes (deberás reemplazarlas con las URLs reales)
  final Map<String, String> imagenesCiudades = {
    'Quito': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe_DbTTKfjCOq_j9oILDwJeTE_p0vy1xqFeQ&s',
    'Guayaquil': 'https://www.shutterstock.com/image-photo/guayaquil-ecuador-november-9th-2014-600nw-2514123113.jpg',
    'Cuenca': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7vGg-TBmN1D_naP9oGmLfA_6YfrRjaswQ5A&s',
    'Manta': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqlvscOYWQeDpMvJ8HVrYgTnFfbgokSNxb3g&s',
    'Ambato': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCc67tP16XBTbxfOGzkVck6urPNUX-Go4y7Q&s',
    'Loja': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPNa_rE4dIKI2UoBgPLZdU0GQi94SivwZMkg&s',
    'Portoviejo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaTCejfBGs8nRXsR0QEfqdyBt9Q3AuqNlblw&s',
    'Ibarra': 'https://www.turismo.gob.ec/wp-content/uploads/2018/09/AR-PC-ANDES-IMBABURA-IBARRA-PARQUE-LA-MERCED-11.jpg',
    'Esmeraldas': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVfS3_WBG71TJAgaKGfpDTj_bX2itGVbSnvw&s',
    'Santo Domingo': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRej4CV1_HANWHFlJL1C_qbW_GXcAZIN65VKA&s',
    'Milagro': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_hDLlsuL-Pc3n7NA9K4oycF0w-WKeyUgmsA&s',
    'Machala': 'https://www.turismo.gob.ec/wp-content/uploads/2020/06/36DC7964-0D4D-4AA9-9F47-B7688D08E2A8.jpeg',
  };

  @override
  void initState() {
    super.initState();
    _cargarCiudades();
  }

  Future<void> _cargarCiudades() async {
    try {
      final response = await http.get(
        Uri.parse('https://jritsqmet.github.io/web-api/ciudades.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          ciudades = (data['ciudades'] as List)
              .map((ciudad) => Ciudad.fromJson(ciudad))
              .toList();
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar ciudades: $error')),
        );
      }
    }
  }

  void _mostrarDetallesCiudad(Ciudad ciudad) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ciudad.nombre),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Provincia: ${ciudad.provincia}'),
              Text('Población: ${ciudad.poblacion}'),
              Text('Latitud: ${ciudad.latitud}'),
              Text('Longitud: ${ciudad.longitud}'),
              const SizedBox(height: 10),
              const Text('Atracciones Turísticas:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...ciudad.atraccionesTuristicas.map((atraccion) => Text('• $atraccion')),
              const SizedBox(height: 10),
              const Text('Lugares de Interés:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...ciudad.lugaresInteres.map((lugar) => Text('• $lugar')),
              const SizedBox(height: 10),
              const Text('Actividades:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...ciudad.actividades.map((actividad) => Text('• $actividad')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ciudades'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ciudades.length,
              itemBuilder: (context, index) {
                final ciudad = ciudades[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imagenesCiudades[ciudad.nombre] ?? 'https://via.placeholder.com/100',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          );
                        },
                      ),
                    ),
                    title: Text(ciudad.nombre),
                    subtitle: Text(ciudad.provincia),
                    onTap: () => _mostrarDetallesCiudad(ciudad),
                  ),
                );
              },
            ),
    );
  }
} 