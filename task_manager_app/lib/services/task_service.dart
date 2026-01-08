import '../models/task.dart';
import '../utils/constants.dart';
import 'api_service.dart';

class TaskService {
  // Obtener todas las tareas
  static Future<List<Task>> getTasks({
    TaskState? estado,
    TaskPriority? prioridad,
    String? search,
  }) async {
    String endpoint = AppConstants.tasksEndpoint;
    final params = <String>[];

    if (estado != null) {
      params.add('estado=${Uri.encodeComponent(estado.value)}');
    }
    if (prioridad != null) {
      params.add('prioridad=${Uri.encodeComponent(prioridad.value)}');
    }
    if (search != null && search.isNotEmpty) {
      params.add('search=${Uri.encodeComponent(search)}');
    }

    if (params.isNotEmpty) {
      endpoint += '?${params.join('&')}';
    }

    final response = await ApiService.get(endpoint);

    if (response['success'] == true) {
      final data = response['data'] as List;
      return data
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response['message'] ?? 'Error al obtener tareas');
    }
  }

  // Obtener tarea por ID
  static Future<Task> getTaskById(int id) async {
    final response = await ApiService.get('${AppConstants.tasksEndpoint}/$id');

    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      return Task.fromJson(data);
    } else {
      throw Exception(response['message'] ?? 'Error al obtener tarea');
    }
  }

  // Crear tarea
  static Future<Task> createTask(Task task) async {
    final response = await ApiService.post(
      AppConstants.tasksEndpoint,
      task.toJson(),
    );

    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      return Task.fromJson(data);
    } else {
      throw Exception(response['message'] ?? 'Error al crear tarea');
    }
  }

  // Actualizar tarea
  static Future<Task> updateTask(int id, Task task) async {
    final response = await ApiService.put(
      '${AppConstants.tasksEndpoint}/$id',
      task.toJson(),
    );

    if (response['success'] == true) {
      final data = response['data'] as Map<String, dynamic>;
      return Task.fromJson(data);
    } else {
      throw Exception(response['message'] ?? 'Error al actualizar tarea');
    }
  }

  // Eliminar tarea
  static Future<void> deleteTask(int id) async {
    final response =
        await ApiService.delete('${AppConstants.tasksEndpoint}/$id');

    if (response['success'] != true) {
      throw Exception(response['message'] ?? 'Error al eliminar tarea');
    }
  }
}
