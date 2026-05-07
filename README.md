# NovaChat AI Analytics — SQL + Python

Análisis de una plataforma de chat con IA usando **SQL** desde **Python** con **SQLite**. Proyecto que simula el flujo real de un **Data Analyst**: preguntas de negocio → SQL → DataFrame → insights.

---

## Stack

- **Lenguaje:** Python 3.12
- **Base de datos:** SQLite
- **Librerías:** pandas, sqlite3, Jupyter Notebook
- **Control de versiones:** Git / GitHub

---

## Estructura del proyecto

```
novachat-analytics/
├── data/
│   └── novachat.db              # Base de datos SQLite (6 tablas, 33 feedbacks)
├── notebooks/
│   └── proyecto_guiado_sql1.ipynb  # Notebook con los 13 ejercicios + insight
├── sql/
│   └── schema.sql               # DDL + seed data compatible con MySQL/TiDB Cloud
├── src/                          # Módulos auxiliares (futuras ampliaciones)
├── .gitignore
├── Dockerfile                    # Contenedor Jupyter listo para ejecutar
├── README.md
└── requirements.txt              # pandas, jupyter, mysql-connector-python
```

---

## Habilidades demostradas

| Skill | Detalle |
|---|---|
| **SQL intermedio** | SELECT, WHERE, GROUP BY, HAVING, ORDER BY, JOINs (3+ tablas), subconsultas escalares, CASE WHEN, COUNT DISTINCT, funciones de agregación, filtrado por fecha con `strftime` |
| **Python + SQL** | Conexión a base de datos local, ejecución de queries parametrizadas con `pandas.read_sql_query`, manejo de cursores y transacciones |
| **Análisis de negocio** | Traducción de preguntas de producto a consultas SQL: distribución de clientes, patrones de uso, rentabilidad por modelo, calidad del servicio (feedback), identificación de candidatos a upgrade |
| **Storytelling con datos** | Cada bloque incluye interpretación de resultados con recomendaciones accionables para stakeholders |

---

## Esquema de la base de datos

6 tablas interconectadas que modelan una plataforma SaaS de chat con IA:

- **usuarios** — registro, plan (free/pro/team) y país
- **modelos** — catálogo de LLMs con coste por 1k tokens
- **conversaciones** — sesiones usuario + modelo
- **mensajes** — histórico con tokens de input/output
- **feedback** — valoraciones positivas/negativas
- **suscripciones** — histórico de planes de pago

---

## Ejercicios resueltos

| # | Consulta | Conceptos SQL |
|---|---|---|
| 1 | Distribución de usuarios por plan | `GROUP BY`, subconsulta escalar para %, `ORDER BY` |
| 2 | Modelos ordenados por coste | `ORDER BY DESC` |
| 3 | Modelos lanzados en 2024 | `strftime`, `BETWEEN`, filtro por fecha |
| 4 | Usuarios por país (> 1) | `HAVING`, filtro de grupos pequeños |
| 5 | Conversaciones por mes (> 5) | `strftime` para agrupar por mes, `HAVING` |
| 6 | Tokens totales y promedio por modelo | `JOIN` 3 tablas, `SUM`, `AVG` |
| 7 | Top 5 modelos más populares | `COUNT(DISTINCT)`, `LIMIT` |
| 8 | Coste estimado por modelo en USD | Cálculo financiero en SQL, `JOIN` 3 tablas |
| 9 | Modelos con peor feedback | `SUM(CASE WHEN)`, conteo condicional, `HAVING >= 5` |
| 10 | Candidatos a upgrade (free heavy users) | Filtro por plan + `HAVING` + `JOIN` 3 tablas |
| 11 | Top 5 usuarios por gasto en tokens | `JOIN` 4 tablas, coste estimado por usuario |
| 12 | Modelos sobre el coste medio | Subconsulta escalar en `WHERE` |
| 13 | Adopción de modelos 2024+ vs pre-2024 | `CASE WHEN`, proporción sobre total |

---

## Cómo ejecutar

### Local (Python)

```bash
# 1. Activar el entorno virtual
venv\Scripts\activate

# 2. Iniciar Jupyter desde la raíz del proyecto
jupyter notebook notebooks\proyecto_guiado_sql1.ipynb

# 3. Ejecutar todas las celdas (Kernel → Restart & Run All)
```

Requiere: `pandas` (instalado en el venv).

### Docker

```bash
# 1. Construir la imagen
docker build -t novachat-analytics .

# 2. Ejecutar el contenedor
docker run -p 8888:8888 novachat-analytics

# 3. Abrir el notebook en el navegador (JupyterLab en http://localhost:8888)
```

El `Dockerfile` expone Jupyter en el puerto 8888 con todas las dependencias preinstaladas.

### TiDB Cloud Serverless (MySQL)

El notebook está preparado para funcionar también con **TiDB Cloud Serverless** (base de datos MySQL-compatible gratuita). Para conectarte:

1. Crea una cuenta gratuita en [tidbcloud.com](https://tidbcloud.com)
2. Crea un cluster Serverless y obtén tus credenciales (host, puerto, usuario, contraseña)
3. Conéctate con cualquier cliente MySQL (Workbench, DBeaver, etc.) y ejecuta el script `schema.sql` para crear las tablas y cargar los datos
4. En el notebook, sustituye los placeholders en la configuración de conexión:

```python
mysql_config = {
    "host":     "TU_HOST.tidbcloud.com",
    "port":     4000,
    "user":     "TU_USUARIO",
    "password": "TU_PASSWORD",
    "database": "ai_chat_analytics",
    "ssl_disabled": False,
}
```

> ⚠️ **Nunca subas credenciales reales a GitHub.** El notebook incluido usa SQLite local para evitar este riesgo.

---

## Autor

**Randy Bonucci** — Ingeniero Informático  
Bootcamp Data & IA — Módulo 2 (SQL)
