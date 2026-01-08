const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth');
const {
    getTasks,
    getTaskById,
    createTask,
    updateTask,
    deleteTask
} = require('../controllers/taskController');

// Todas las rutas requieren autenticación
router.use(authMiddleware);

// GET /tasks - Obtener todas las tareas (con filtros opcionales)
router.get('/', getTasks);

// POST /tasks - Crear nueva tarea
router.post('/', createTask);

// GET /tasks/:id - Obtener tarea específica
router.get('/:id', getTaskById);

// PUT /tasks/:id - Actualizar tarea
router.put('/:id', updateTask);

// DELETE /tasks/:id - Eliminar tarea
router.delete('/:id', deleteTask);

module.exports = router;
