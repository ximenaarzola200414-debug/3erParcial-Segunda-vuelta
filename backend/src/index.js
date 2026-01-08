const express = require('express');
const cors = require('cors');
require('dotenv').config();

const { testConnection } = require('./config/db');
const authRoutes = require('./routes/auth');
const taskRoutes = require('./routes/tasks');

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Logging middleware
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
    next();
});

// Rutas
app.get('/', (req, res) => {
    res.json({
        success: true,
        message: 'Task Manager API - v1.0',
        endpoints: {
            auth: {
                register: 'POST /auth/register',
                login: 'POST /auth/login'
            },
            tasks: {
                list: 'GET /tasks',
                create: 'POST /tasks',
                get: 'GET /tasks/:id',
                update: 'PUT /tasks/:id',
                delete: 'DELETE /tasks/:id'
            }
        }
    });
});

app.use('/auth', authRoutes);
app.use('/tasks', taskRoutes);

// Manejo de rutas no encontradas
app.use((req, res) => {
    res.status(404).json({
        success: false,
        message: 'Ruta no encontrada'
    });
});

// Manejo de errores global
app.use((err, req, res, next) => {
    console.error('Error:', err);
    res.status(err.status || 500).json({
        success: false,
        message: err.message || 'Error interno del servidor'
    });
});

// Iniciar servidor
const startServer = async () => {
    try {
        // Verificar conexión a la base de datos
        await testConnection();

        app.listen(PORT, () => {
            console.log(`\n🚀 Servidor corriendo en http://localhost:${PORT}`);
            console.log(`📝 Documentación API disponible en http://localhost:${PORT}\n`);
        });
    } catch (error) {
        console.error('Error al iniciar el servidor:', error);
        process.exit(1);
    }
};

startServer();
