class Ciudad {
  final String nombre;
  final String provincia;
  final int poblacion;
  final double latitud;
  final double longitud;
  final List<String> atraccionesTuristicas;
  final List<String> lugaresInteres;
  final List<String> actividades;

  Ciudad({
    required this.nombre,
    required this.provincia,
    required this.poblacion,
    required this.latitud,
    required this.longitud,
    required this.atraccionesTuristicas,
    required this.lugaresInteres,
    required this.actividades,
  });

  factory Ciudad.fromJson(Map<String, dynamic> json) {
    return Ciudad(
      nombre: json['nombre'],
      provincia: json['provincia'],
      poblacion: json['poblacion'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      atraccionesTuristicas: List<String>.from(json['atracciones_turisticas']),
      lugaresInteres: List<String>.from(json['lugares_interes']),
      actividades: List<String>.from(json['actividades']),
    );
  }
} 