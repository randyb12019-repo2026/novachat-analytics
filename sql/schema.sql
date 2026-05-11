-- NovaChat AI Analytics - Esquema y datos para TiDB Cloud (MySQL)
-- Creado a partir del proyecto SQL + Python

CREATE DATABASE IF NOT EXISTS ai_chat_analytics;
USE ai_chat_analytics;

-- Tabla: usuarios
CREATE TABLE usuarios (
    user_id INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    pais VARCHAR(50),
    plan VARCHAR(20) NOT NULL,
    fecha_registro DATE NOT NULL
);

-- Tabla: modelos
CREATE TABLE modelos (
    modelo_id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    proveedor VARCHAR(50) NOT NULL,
    coste_por_1k_tokens DECIMAL(8,5) NOT NULL,
    fecha_lanzamiento DATE NOT NULL
);

-- Tabla: conversaciones
CREATE TABLE conversaciones (
    conversacion_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    modelo_id INT NOT NULL,
    titulo VARCHAR(200),
    fecha_inicio DATETIME NOT NULL
);

-- Tabla: mensajes
CREATE TABLE mensajes (
    mensaje_id INT PRIMARY KEY,
    conversacion_id INT NOT NULL,
    rol VARCHAR(20) NOT NULL,
    tokens_input INT NOT NULL DEFAULT 0,
    tokens_output INT NOT NULL DEFAULT 0,
    timestamp DATETIME NOT NULL
);

-- Tabla: feedback
CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    mensaje_id INT NOT NULL,
    user_id INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    comentario TEXT,
    fecha DATETIME NOT NULL
);

-- Tabla: suscripciones
CREATE TABLE suscripciones (
    suscripcion_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    plan VARCHAR(20) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    importe_mensual DECIMAL(8,2) NOT NULL,
    activa TINYINT(1) NOT NULL
);

-- Datos de ejemplo (versión reducida)
INSERT INTO usuarios VALUES
(1, 'Ana Garcia', 'ana.garcia@correo.com', 'Espana', 'pro', '2025-06-15'),
(2, 'Carlos Ramirez', 'c.ramirez@correo.com', 'Mexico', 'free', '2025-08-22'),
(3, 'Maria Fernandez', 'maria.f@correo.com', 'Espana', 'team', '2025-04-10'),
(4, 'Diego Torres', 'd.torres@correo.com', 'Argentina', 'free', '2025-10-08'),
(5, 'Lucia Martin', 'lucia.m@correo.com', 'Espana', 'pro', '2025-07-19');

INSERT INTO modelos VALUES
(1, 'GPT-4', 'OpenAI', 0.0300, '2023-03-14'),
(2, 'GPT-4 Turbo', 'OpenAI', 0.0100, '2023-11-06'),
(3, 'GPT-3.5 Turbo', 'OpenAI', 0.0015, '2022-11-30'),
(4, 'GPT-4o', 'OpenAI', 0.0050, '2024-05-13'),
(5, 'Claude 3 Opus', 'Anthropic', 0.0150, '2024-02-29'),
(6, 'Claude 3 Sonnet', 'Anthropic', 0.0030, '2024-02-29'),
(7, 'Claude 3 Haiku', 'Anthropic', 0.00025, '2024-02-29'),
(8, 'Llama 3 8B', 'Meta', 0.0002, '2024-04-18'),
(9, 'Llama 3 70B', 'Meta', 0.0009, '2024-04-18'),
(10, 'Gemini Pro', 'Google', 0.0010, '2023-12-13'),
(11, 'Gemini Ultra', 'Google', 0.0100, '2024-02-15'),
(12, 'Mistral Large', 'Mistral AI', 0.0040, '2024-02-26'),
(13, 'DeepSeek R1', 'DeepSeek', 0.0005, '2025-01-20');

INSERT INTO conversaciones VALUES
(1, 1, 11, 'Explicacion de regresion lineal', '2025-07-29 17:27:00'),
(2, 1, 11, 'Estructura de proyecto Django', '2025-09-24 19:41:00'),
(3, 1, 4, 'Preparar entrevista tecnica', '2025-12-15 21:22:00'),
(4, 1, 11, 'Resumen de paper de ML', '2025-12-17 17:12:00'),
(5, 2, 3, 'Revisar texto en ingles', '2026-03-04 12:29:00');

INSERT INTO mensajes VALUES
(1, 1, 'user', 43, 0, '2025-07-29 17:27:32'),
(2, 1, 'assistant', 0, 338, '2025-07-29 17:28:41'),
(3, 2, 'user', 76, 0, '2025-09-24 19:42:02'),
(4, 2, 'assistant', 0, 703, '2025-09-24 19:42:42'),
(5, 2, 'user', 21, 0, '2025-09-24 19:43:07'),
(6, 2, 'assistant', 0, 512, '2025-09-24 19:44:02');

INSERT INTO feedback VALUES
(1, 6, 1, 'positivo', 'Claro y bien estructurado', '2025-09-24 19:44:13'),
(2, 15, 2, 'positivo', 'Resolvio mi duda perfectamente', '2026-03-04 12:32:42'),
(3, 22, 2, 'positivo', NULL, '2025-11-13 15:29:01'),
(4, 33, 2, 'positivo', 'Codigo correcto a la primera', '2025-12-28 17:00:52'),
(5, 35, 2, 'positivo', NULL, '2025-12-28 17:02:47');

INSERT INTO suscripciones VALUES
(1, 1, 'pro', '2025-06-15', NULL, 20.0, 1),
(2, 3, 'team', '2025-04-10', NULL, 80.0, 1),
(3, 5, 'pro', '2025-07-19', NULL, 20.0, 1),
(4, 8, 'pro', '2025-06-28', NULL, 20.0, 1),
(5, 9, 'pro', '2025-02-05', '2025-05-11', 20.0, 0);
