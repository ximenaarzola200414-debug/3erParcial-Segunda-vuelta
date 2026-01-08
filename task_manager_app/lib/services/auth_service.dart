import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class AuthService {
  // Registrar usuario
  static Future<User> register({
    required String nombre,
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      '${AppConstants.authEndpoint}/register',
      {
        'nombre': nombre,
        'email': email,
        'password': password,
      },
    );

    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = User.fromJson(data['user'] as Map<String, dynamic>);

      // Guardar token y datos del usuario
      await ApiService.saveToken(token);
      await _saveUserData(user);

      return user;
    } else {
      throw Exception(response['message'] ?? 'Error al registrar');
    }
  }

  // Login
  static Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      '${AppConstants.authEndpoint}/login',
      {
        'email': email,
        'password': password,
      },
    );

    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      final token = data['token'] as String;
      final user = User.fromJson(data['user'] as Map<String, dynamic>);

      // Guardar token y datos del usuario
      await ApiService.saveToken(token);
      await _saveUserData(user);

      return user;
    } else {
      throw Exception(response['message'] ?? 'Error al iniciar sesión');
    }
  }

  // Logout
  static Future<void> logout() async {
    await ApiService.deleteToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove(AppConstants.userNameKey);
    await prefs.remove(AppConstants.userEmailKey);
  }

  // Verificar si hay sesión activa
  static Future<bool> isLoggedIn() async {
    final token = await ApiService.getToken();
    return token != null && token.isNotEmpty;
  }

  // Obtener usuario guardado
  static Future<User?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt(AppConstants.userIdKey);
    final nombre = prefs.getString(AppConstants.userNameKey);
    final email = prefs.getString(AppConstants.userEmailKey);

    if (id != null && nombre != null && email != null) {
      return User(id: id, nombre: nombre, email: email);
    }
    return null;
  }

  // Guardar datos del usuario localmente
  static Future<void> _saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.userIdKey, user.id);
    await prefs.setString(AppConstants.userNameKey, user.nombre);
    await prefs.setString(AppConstants.userEmailKey, user.email);
  }
}
