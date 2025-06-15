class Platillo {
  final String id;
  final String nombre;
  final String ciudad;

  Platillo({
    required this.id,
    required this.nombre,
    required this.ciudad,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'ciudad': ciudad,
    };
  }
} 