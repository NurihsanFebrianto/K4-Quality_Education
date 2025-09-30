import 'dart:async';
import '../database/user_db.dart';
import '../models/user.dart';
import '../utils/preferences.dart';

class AuthProvider {
  final _controller = StreamController<User?>.broadcast();
  Stream<User?> get user => _controller.stream;

  Future<bool> signUp(String name, String email, String password) async {
    final existingUser = await UserDB.instance.getUserByEmail(email);
    if (existingUser != null) return false;
    await UserDB.instance.insertUser(
      User(name: name, email: email, password: password),
    );
    return true;
  }

  Future<bool> login(String email, String password) async {
    final user = await UserDB.instance.getUserByEmail(email);
    if (user != null && user.password == password) {
      await Preferences.saveUsername(user.name);
      _controller.sink.add(user);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Preferences.logout();
    _controller.sink.add(null);
  }

  void dispose() => _controller.close();
}
