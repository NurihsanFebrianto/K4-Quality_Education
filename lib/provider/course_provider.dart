import 'dart:async';
import '../database/course_db.dart';
import '../models/course.dart';

class CourseProvider {
  final _controller = StreamController<List<Course>>.broadcast();
  Stream<List<Course>> get courses => _controller.stream;

  void loadCourses() async {
    final data = await CourseDB.instance.getAllCourses();
    _controller.sink.add(data);
  }

  void addCourse(Course course) async {
    await CourseDB.instance.insertCourse(course);
    loadCourses();
  }

  void updateCourse(Course course) async {
    await CourseDB.instance.updateCourse(course);
    loadCourses();
  }

  void deleteCourse(int id) async {
    await CourseDB.instance.deleteCourse(id);
    loadCourses();
  }

  void dispose() => _controller.close();
}
