import 'package:sqflite/sqflite.dart';
import '../models/course.dart';
import 'user_db.dart';

class CourseDB {
  static final CourseDB instance = CourseDB._init();
  static Database? _database;

  CourseDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await UserDB.instance.database; // Reuse DB from UserDB
    return _database!;
  }

  Future<int> insertCourse(Course course) async {
    final db = await instance.database;
    return await db.insert('courses', course.toMap());
  }

  Future<int> updateCourse(Course course) async {
    final db = await instance.database;
    return await db.update(
      'courses',
      course.toMap(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  Future<int> deleteCourse(int id) async {
    final db = await instance.database;
    return await db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Course>> getAllCourses() async {
    final db = await instance.database;
    final result = await db.query('courses');
    return result.map((map) => Course.fromMap(map)).toList();
  }
}
