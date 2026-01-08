import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;
  TaskState? _filterEstado;
  TaskPriority? _filterPrioridad;
  String? _searchQuery;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;
  TaskState? get filterEstado => _filterEstado;
  TaskPriority? get filterPrioridad => _filterPrioridad;
  String? get searchQuery => _searchQuery;

  // Cargar tareas
  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tasks = await TaskService.getTasks(
        estado: _filterEstado,
        prioridad: _filterPrioridad,
        search: _searchQuery,
      );
      _error = null;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Crear tarea
  Future<bool> createTask(Task task) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newTask = await TaskService.createTask(task);
      _tasks.insert(0, newTask);
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Actualizar tarea
  Future<bool> updateTask(int id, Task task) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedTask = await TaskService.updateTask(id, task);
      final index = _tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        _tasks[index] = updatedTask;
      }
      _error = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Eliminar tarea
  Future<bool> deleteTask(int id) async {
    try {
      await TaskService.deleteTask(id);
      _tasks.removeWhere((t) => t.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  // Filtrar por estado
  void setFilterEstado(TaskState? estado) {
    _filterEstado = estado;
    loadTasks();
  }

  // Filtrar por prioridad
  void setFilterPrioridad(TaskPriority? prioridad) {
    _filterPrioridad = prioridad;
    loadTasks();
  }

  // Buscar
  void setSearchQuery(String? query) {
    _searchQuery = query;
    loadTasks();
  }

  // Limpiar filtros
  void clearFilters() {
    _filterEstado = null;
    _filterPrioridad = null;
    _searchQuery = null;
    loadTasks();
  }

  // Limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Obtener estadísticas
  Map<String, int> get statistics {
    return {
      'total': _tasks.length,
      'pendiente': _tasks.where((t) => t.estado == TaskState.pendiente).length,
      'enProgreso':
          _tasks.where((t) => t.estado == TaskState.enProgreso).length,
      'hecha': _tasks.where((t) => t.estado == TaskState.hecha).length,
      'alta': _tasks.where((t) => t.prioridad == TaskPriority.alta).length,
    };
  }
}
