# Proyecto 1: Diseño Digital Combinacional en Dispositivos Programables. 

Curso: Diseño Lógico
---
Estudiantes:
- David Araya
- Nicolas Castro
- Sebastián Fallas

# Descripción general del circuito completo.

El sistema implementa un circuito digital para la transmisión y recuperación de información utilizando el código de Hamming (7,4). Su propósito es permitir la detección y corrección de errores de un solo bit en una palabra binaria transmitida entre dos FPGAs.
El sistema se divide en dos bloques principales: Transmisor y Receptor. El transmisor genera y codifica la información, mientras que el receptor la analiza, detecta errores y recupera los datos originales.
El flujo general consiste en la entrada de una palabra de 4 bits, su codificación a 7 bits, la posible inserción de error, la transmisión, la detección del error en el receptor, su corrección y la visualización del resultado.

---

# Subsistemas. 
Diagramas de bloques y funcionamiento. 

## Transmisor

### Subsistema de lectura y visualización
Este módulo recibe una palabra de 4 bits mediante interruptores y la muestra en un display de 7 segmentos en formato hexadecimal. Permite al usuario verificar el valor ingresado antes de la codificación.

### Codificador Hamming (7,4) y paridad par
Toma los 4 bits de entrada y genera una palabra de 7 bits agregando 3 bits de paridad. Estos bits se calculan mediante operaciones XOR para permitir la detección y corrección de errores en el receptor.

### Codificador de binario a 7 segmentos
Este módulo toma la palabra de 4 bits ingresada por el usuario, utiliza un conjunto de conmuntadores y mapas de Karnaugh para generar el display de 7 segmentos. Permite visualizar el valor en formato hexadecimal, facilitando la verificación del dato antes de ser procesado.

### Generador de error
Recibe la palabra codificada de 7 bits y un valor de control de 3 bits que indica la posición del bit a alterar. Si se selecciona una posición válida, el módulo invierte ese bit, simulando un error en la transmisión.

### Salida del transmisor
La palabra codificada, con o sin error, se envía al receptor mediante conexiones físicas entre FPGAs.



## Receptor

### Subsistema de recepción
Recibe la palabra de 7 bits proveniente del transmisor y la distribuye a los módulos de detección y corrección de errores.

### Verificador de paridad
Calcula el síndrome de error a partir de los bits recibidos. Este síndrome indica si existe un error y, en caso afirmativo, la posición del bit erróneo.

<p align="center">
<img width="660" height="224" alt="DecodificadorParidad drawio" src="https://github.com/user-attachments/assets/41e88b68-f1fa-4cbf-93a7-61b67afe3e49" />
</p>

### Corrector de error
Utiliza el síndrome para identificar y corregir el bit erróneo mediante la inversión del mismo. A partir de la palabra corregida, extrae los 4 bits originales de información.

<p align="center">
<img width="560" height="121" alt="CorrectorError drawio" src="https://github.com/user-attachments/assets/056a7159-1ce5-4c61-bfb3-3e928dea962e" />
</p>

### Visualización en LEDs
Muestra la palabra corregida en formato binario utilizando LEDs, permitiendo observar directamente los bits recuperados.

<p align="center">
<img width="401" height="51" alt="DespliegueLeds drawio" src="https://github.com/user-attachments/assets/d57147ff-0395-4b4d-883d-f4665d344a9b" />
</p>

### Display de 7 segmentos
Convierte la palabra corregida a formato hexadecimal para su visualización en un display de 7 segmentos.

<p align="center">
<img width="431" height="71" alt="Display7seg drawio" src="https://github.com/user-attachments/assets/9d38b8ba-8fc1-488d-be66-13e315ed452a" />
</p>

### Selector
Permite elegir entre mostrar la palabra corregida o la posición del error. Está controlado por un interruptor externo y funciona como un multiplexor entre ambas salidas.

<p align="center">
<img width="491" height="310" alt="Selector drawio" src="https://github.com/user-attachments/assets/22033ab8-03b9-4e66-b585-45275cd17f10" />
</p>

---

# Ecuaciones booleanas usadas para el circuito corrector de error.

---

# Ecuaciones booleanas usadas para los 7-segmentos.

---

# Simulación funcional del sistema completo.

---

# Análisis de consumo de recursos en la FPGA y del consumo de potencia.

---

# Principales problemas hallados.

# Soluciones aplicadas.

---


