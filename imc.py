def calcular_imc(peso, altura):
    """Calcula el Índice de Masa Corporal (IMC).

    Args:
        peso (float): Peso en kilogramos.
        altura (float): Altura en metros.

    Returns:
        float: El valor del IMC.
    """
    
    return peso / (altura ** 2)

def clasificar_imc(imc):
    """Clasifica el IMC en categorías.

    Args:
        imc (float): El valor del IMC.

    Returns:
        str: La categoría del IMC.
    """
    if imc < 18.5:
        return 1
    elif 18.5 <= imc < 24.9:
        return 2
    elif 25 <= imc < 29.9:
        return 3
    elif 30 <= imc < 34.9:
        return 4
    elif 35 <= imc < 39.9:
        return 5
    else:
        return 6

def main():
    """Función principal para calcular y mostrar el IMC de un curso."""
    imc_promedio = 0
    num_estudiantes = int(input("Ingrese el numero de estudiantes: "))
    bajo_peso = normal = sobrepeso = obeso_g1 = obeso_g2 = obeso_g3 = 0

    for i in range(num_estudiantes):
        print(f"\n--- Datos del estudiante {i + 1} ---")
        
        peso = float(input("Peso en kg (ej. 70.5): "))
        altura = float(input("Altura en metros (ej. 1.75): "))
        
        imc = calcular_imc(peso, altura)
        clasificacion = clasificar_imc(imc)
        
        if clasificacion == 1: bajo_peso += 1
        elif clasificacion == 2: normal += 1
        elif clasificacion == 3: sobrepeso += 1
        elif clasificacion == 4: obeso_g1 += 1
        elif clasificacion == 5: obeso_g2 += 1
        elif clasificacion == 6: obeso_g3 += 1
        
        imc_promedio += imc

    imc_promedio /= num_estudiantes
 
    print("\n--- Resultados del IMC del Curso ---")
    print(f"IMC PROMEDIO: {imc_promedio}")
    print("\n--- Clasificacion del IMC de los estudiantes ---")
    print(f"Bajo peso: {bajo_peso}")
    print(f"Peso Normal: {normal}")
    print(f"Sobrepeso: {sobrepeso}")
    print(f"Obesidad grado I: {obeso_g1}")
    print(f"Obesidad grado II: {obeso_g2}")
    print(f"Obesidad grado III (Morbida): {obeso_g3}")

main()