import 'package:backend/provider/auth_provider.dart';
import 'package:backend/provider/course_provider.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';
import '../utils/preferences.dart';
import 'login_page.dart';

class CoursePage extends StatefulWidget {
  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final CourseProvider _provider = CourseProvider();
  final AuthProvider _auth = AuthProvider();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  String? _username; // <-- untuk tampung username

  @override
  void initState() {
    super.initState();
    _provider.loadCourses();
    _loadUsername(); // <-- load nama user dari SharedPreferences
  }

  Future<void> _loadUsername() async {
    final name = await Preferences.getUsername();
    setState(() {
      _username = name;
    });
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_username != null ? 'Welcome, $_username!' : 'Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.logout();
              await Preferences.logout(); // <-- hapus username di SharedPreferences
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Course>>(
        stream: _provider.courses,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                title: Text(course.title),
                subtitle: Text(course.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _title.text = course.title;
                        _desc.text = course.description;
                        showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: const Text('Edit Course'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(controller: _title),
                                    TextField(controller: _desc),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _provider.updateCourse(
                                        Course(
                                          id: course.id,
                                          title: _title.text,
                                          description: _desc.text,
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _provider.deleteCourse(course.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _title.clear();
          _desc.clear();
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text('Add Course'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _title,
                        decoration: const InputDecoration(hintText: 'Title'),
                      ),
                      TextField(
                        controller: _desc,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _provider.addCourse(
                          Course(title: _title.text, description: _desc.text),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
