class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://192.168.1.72:3000';
  static const String authEndpoint = '/auth';
  static const String tasksEndpoint = '/tasks';

  // OpenWeather API Configuration
  static const String weatherApiKey =
      'TU_API_KEY_AQUI'; // Obtener gratis en https://openweathermap.org/api
  static const String weatherBaseUrl =
      'https://api.openweathermap.org/data/2.5';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';

  // Timeout
  static const Duration requestTimeout = Duration(seconds: 30);
}
