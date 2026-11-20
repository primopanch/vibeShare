# VibeShare

Red social: proyecto de la Fase 2 (arquitectura de datos y esqueleto funcional).

## Contenido
- `docs/MER.png` y `docs/MER.pdf`: Modelo Entidad-Relación (fuente en `docs/mer.dot`)
- `database.sql`: tablas y datos de prueba
- `index.php`: login (diseño basado en el prototipo de Figma)
- `login.php`: valida al usuario contra la base de datos (PDO + `password_verify`)
- `inicio.php`: dashboard con barra superior y pestañas de navegación
- Secciones: Mi perfil, Amigos, Notificaciones, Mensajes, Configuración, Usuarios y Reportes (solo admin)
- `logout.php`: cierra la sesión

## Usuarios de prueba (contraseña: `Vibe2026!`)
| Correo | Rol |
|---|---|
| admin@vibeshare.com | admin (ve todas las secciones) |
| joseph@vibeshare.com | usuario |
| josuke@vibeshare.com | usuario |

