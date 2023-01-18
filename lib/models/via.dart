import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'via.g.dart';

@HiveType(typeId: 1)
class Via {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String autor;

  @HiveField(2)
  final int dificultad;

  @HiveField(3)
  final String comentario;

  @HiveField(4)
  final List<String> presas;




  Via({
    required this.name,
    required this.autor,
    required this.dificultad,
    required this.comentario,
    required this.presas,

  });
}
