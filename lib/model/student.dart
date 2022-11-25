import 'package:hive_flutter/adapters.dart';
part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final dynamic imagepath;

  @HiveField(4)
  final String qualification;

  Student({
    required this.name,
    required this.age,
    required this.place,
    required this.qualification,
    this.imagepath,
    String? imagePath,
  });
}
