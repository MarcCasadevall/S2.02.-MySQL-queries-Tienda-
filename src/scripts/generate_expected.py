import os
import pymysql
import re
from decimal import Decimal

# Conectar a MySQL usando PyMySQL y forzando utf8mb4
db = pymysql.connect(
    host="127.0.0.1",
    user="root",
    password="root",
    database="tienda",
    charset="utf8mb4",
    use_unicode=True,
    autocommit=True
)

cursor = db.cursor()

# 🔹 Asegurar UTF-8 en la comunicación con MySQL
cursor.execute("SET NAMES utf8mb4 COLLATE utf8mb4_general_ci;")
cursor.execute("SET CHARACTER SET utf8mb4;")
cursor.execute("SET character_set_connection=utf8mb4;")



def decode_row(row):
    return tuple(value.decode("utf-8") if isinstance(value, bytes) else value for value in row)


# Leer queries desde queries.sql
def read_queries(file_path="./queries/queries.sql"):
    with open(file_path, "r") as f:
        queries = f.read()
    return [q.strip() for q in re.split(r';\s*\n', queries) if q.strip()]

# Función para formatear valores (misma lógica que en la evaluación)
def format_value(value):
    """ Formatea valores numéricos para garantizar siempre 2 decimales. """
    if value is None:
        return "NULL"
    
    if isinstance(value, (int, float, Decimal)):
        return f"{Decimal(value):.2f}"  # 🔹 Asegura siempre 2 decimales
    if isinstance(value, bytes):
        return value.decode('utf-8')  # <- 👈 prueba si vienen como bytes

    return str(value)  # Para cadenas y otros valores


# Crear carpeta si no existe
os.makedirs("src/expected_results", exist_ok=True)

# Obtener las queries del archivo
queries = read_queries()

# Ejecutar cada query y guardar el resultado en un archivo .out
for i, query in enumerate(queries, start=1):
    try:
        cursor.execute(query)
        columns = [desc[0] for desc in cursor.description]
        result = cursor.fetchall()
        result = [decode_row(row) for row in result]


        # Formatear resultados
        result_formatted = [" | ".join(columns)]
        for row in result:
            formatted_row = " | ".join(format_value(value) for value in row)
            result_formatted.append(formatted_row)

          # 🔍 **Depuración: Mostrar en pantalla los primeros resultados antes de escribir**
        print(f"🔹 Query {i} - Primeras 3 líneas de resultados:")
        print("\n".join(result_formatted[:5]))  # Muestra las primeras 3 líneas del resultado


        # Guardar en un archivo .out
        with open(f"src/expected_results/query_{i}.out", "w", encoding="utf-8") as f:
            f.write("\n".join(result_formatted))


        print(f"✅ Resultados esperados guardados en: expected_results/query_{i}.out")

    except Exception as e:
        print(f"⚠️ Error en Query {i}: {str(e)}")

# Cerrar conexión
cursor.close()
db.close()
print("🎉 Archivos de resultados esperados generados con éxito.")
