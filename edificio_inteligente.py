# Estado inicial
estado = {
    "hora": "mañana",
    "presencia": "oficina",
    "luz_natural": 50,
    "temperatura": 18,
    "ventana": "cerrada",
    "consumo_energia": 800,
    "equipos": {"estacion1": "en-uso", "estacion2": "sin-uso"}
}

# Reglas
def regla_apagar_luces(estado):
    if estado["presencia"] == "ninguna":
        print("Apagando luces porque no hay presencia en la oficina.")

def regla_ajustar_intensidad_luces(estado):
    if estado["luz_natural"] > 70:
        print("Reduciendo la intensidad de las luces debido a luz natural alta.")

def regla_activar_calefaccion(estado):
    if estado["temperatura"] < 20:
        print(f"Activando calefacción. Temperatura actual: {estado['temperatura']}°C.")

def regla_apagar_climatizacion_ventana_abierta(estado):
    if estado["ventana"] == "abierta":
        print("Apagando climatización porque hay una ventana abierta.")

def regla_hibernar_estaciones(estado):
    for equipo, estado_equipo in estado["equipos"].items():
        if estado_equipo == "sin-uso":
            print(f"Hibernando la estación de trabajo: {equipo}")

def regla_alerta_consumo_alto(estado):
    if estado["consumo_energia"] > 1000:
        print(f"¡Alerta! Consumo energético alto: {estado['consumo_energia']} watts.")

# Ejecución de reglas
def ejecutar_reglas(estado):
    reglas = [
        regla_apagar_luces,
        regla_ajustar_intensidad_luces,
        regla_activar_calefaccion,
        regla_apagar_climatizacion_ventana_abierta,
        regla_hibernar_estaciones,
        regla_alerta_consumo_alto
    ]
    for regla in reglas:
        regla(estado)

# Simulación
print("=== Simulación inicial ===")
ejecutar_reglas(estado)

# Cambiar hechos
estado["presencia"] = "ninguna"
estado["luz_natural"] = 80
estado["temperatura"] = 15
estado["ventana"] = "abierta"
estado["consumo_energia"] = 1200

print("\n=== Simulación con nuevos hechos ===")
ejecutar_reglas(estado)
