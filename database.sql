-- VibeShare - Esquema de base de datos (MySQL / MariaDB)
-- Importar desde phpMyAdmin o: mysql -u USUARIO -p NOMBRE_BD < database.sql

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS reportes, notificaciones, mensajes, amistades, me_gusta, comentarios, publicaciones, usuarios;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE usuarios (
  id_usuario      INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(100) NOT NULL,
  correo          VARCHAR(150) NOT NULL UNIQUE,
  contrasena      VARCHAR(255) NOT NULL,          -- hash de password_hash()
  biografia       VARCHAR(300) NULL,
  foto_perfil     VARCHAR(255) NULL,
  rol             ENUM('usuario','admin') NOT NULL DEFAULT 'usuario',
  fecha_registro  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE publicaciones (
  id_publicacion    INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario        INT NOT NULL,
  texto             TEXT NOT NULL,
  imagen            VARCHAR(255) NULL,
  visibilidad       ENUM('publico','amigos') NOT NULL DEFAULT 'publico',
  fecha_publicacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pub_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE comentarios (
  id_comentario  INT AUTO_INCREMENT PRIMARY KEY,
  id_publicacion INT NOT NULL,
  id_usuario     INT NOT NULL,
  contenido      VARCHAR(500) NOT NULL,
  fecha_hora     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_com_pub     FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE,
  CONSTRAINT fk_com_usuario FOREIGN KEY (id_usuario)     REFERENCES usuarios(id_usuario)         ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE me_gusta (
  id_usuario     INT NOT NULL,
  id_publicacion INT NOT NULL,
  fecha          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_usuario, id_publicacion),
  CONSTRAINT fk_mg_usuario FOREIGN KEY (id_usuario)     REFERENCES usuarios(id_usuario)         ON DELETE CASCADE,
  CONSTRAINT fk_mg_pub     FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE amistades (
  id_amistad        INT AUTO_INCREMENT PRIMARY KEY,
  id_solicitante    INT NOT NULL,
  id_receptor       INT NOT NULL,
  estado            ENUM('pendiente','aceptada','rechazada') NOT NULL DEFAULT 'pendiente',
  fecha_solicitud   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_respuesta   DATETIME NULL,
  UNIQUE KEY uq_par (id_solicitante, id_receptor),
  CONSTRAINT fk_am_sol FOREIGN KEY (id_solicitante) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
  CONSTRAINT fk_am_rec FOREIGN KEY (id_receptor)    REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE mensajes (
  id_mensaje     INT AUTO_INCREMENT PRIMARY KEY,
  id_emisor      INT NOT NULL,
  id_receptor    INT NOT NULL,
  contenido      VARCHAR(1000) NOT NULL,
  leido          TINYINT(1) NOT NULL DEFAULT 0,
  fecha_envio    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_msg_emi FOREIGN KEY (id_emisor)   REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
  CONSTRAINT fk_msg_rec FOREIGN KEY (id_receptor) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notificaciones (
  id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario      INT NOT NULL,                 -- quien recibe la notificación
  id_origen       INT NULL,                     -- quien la provoca
  tipo            ENUM('me_gusta','comentario','solicitud','amistad_aceptada','mensaje') NOT NULL,
  id_referencia   INT NULL,                     -- id de publicación / comentario / solicitud
  leida           TINYINT(1) NOT NULL DEFAULT 0,
  fecha           DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_not_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
  CONSTRAINT fk_not_origen  FOREIGN KEY (id_origen)  REFERENCES usuarios(id_usuario) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE reportes (
  id_reporte     INT AUTO_INCREMENT PRIMARY KEY,
  id_reportante  INT NOT NULL,
  id_publicacion INT NULL,
  id_comentario  INT NULL,
  motivo         VARCHAR(300) NOT NULL,
  estado         ENUM('pendiente','revisado','descartado') NOT NULL DEFAULT 'pendiente',
  id_admin       INT NULL,                      -- administrador que lo revisa
  fecha          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rep_usuario FOREIGN KEY (id_reportante)  REFERENCES usuarios(id_usuario)         ON DELETE CASCADE,
  CONSTRAINT fk_rep_pub     FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE,
  CONSTRAINT fk_rep_com     FOREIGN KEY (id_comentario)  REFERENCES comentarios(id_comentario)   ON DELETE CASCADE,
  CONSTRAINT fk_rep_admin   FOREIGN KEY (id_admin)       REFERENCES usuarios(id_usuario)         ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ------------------------------------------------------------
-- Datos de prueba  (contraseña de todos los usuarios: Vibe2026!)
-- ------------------------------------------------------------
INSERT INTO usuarios (nombre_completo, correo, contrasena, biografia, rol) VALUES
('Administrador VibeShare', 'admin@vibeshare.com',  '$2y$10$qT8FGc.6FStUbZQVNjPrmeVJbs/jmsek3oKrIZlvCA8Y47NWeEgyS', 'Cuenta de administración.', 'admin'),
('Joseph Joestar',          'joseph@vibeshare.com', '$2y$10$qT8FGc.6FStUbZQVNjPrmeVJbs/jmsek3oKrIZlvCA8Y47NWeEgyS', 'Tu próxima frase será...', 'usuario'),
('Josuke Higashikata',      'josuke@vibeshare.com', '$2y$10$qT8FGc.6FStUbZQVNjPrmeVJbs/jmsek3oKrIZlvCA8Y47NWeEgyS', 'Vecino de Morioh.', 'usuario');

INSERT INTO publicaciones (id_usuario, texto) VALUES
(2, 'Hoy usé Hermit Purple para revelar una foto del bar donde cené anoche.'),
(3, 'Mañana de peluquería en Morioh: el pompadour no se arregla solo.');

INSERT INTO comentarios (id_publicacion, id_usuario, contenido) VALUES
(1, 3, '¡Jajaja, qué buena foto!');

INSERT INTO me_gusta (id_usuario, id_publicacion) VALUES (3, 1), (2, 2);

INSERT INTO amistades (id_solicitante, id_receptor, estado) VALUES (2, 3, 'aceptada');

INSERT INTO mensajes (id_emisor, id_receptor, contenido) VALUES (2, 3, '¿Vamos por un café?');

INSERT INTO notificaciones (id_usuario, id_origen, tipo, id_referencia) VALUES
(2, 3, 'me_gusta', 1),
(2, 3, 'comentario', 1);
