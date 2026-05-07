FROM python:3.12-slim

WORKDIR /app

# Copiar archivos del proyecto
COPY data/novachat.db data/
COPY notebooks/proyecto_guiado_sql1.ipynb notebooks/

# Instalar dependencias
RUN pip install --no-cache-dir pandas jupyter

# Exponer puerto de Jupyter
EXPOSE 8888

# Ejecutar Jupyter sin token
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
