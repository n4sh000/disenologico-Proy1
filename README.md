# Proyecto 1: Diseño Digital Combinacional en Dispositivos Programables. 
Curso: Diseño Lógico

Profesor: Dr.-Ing Alfonso Chacon Rodriguez 

Estudiantes:
- David Araya Mora
- Nicolas Castro Sanchez
- Sebastián Fallas Mora

---

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

<p align="center">
<img width="526" height="516" alt="Codificador drawio" src="https://github.com/user-attachments/assets/107ccbf7-b4a5-409f-9383-ea4d98092acd" />
</p>

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

codigo_corregido[0] = codigo[0] ⊕ (~p2 ~p1 ~p0)

codigo_corregido[1] = codigo[1] ⊕ (~p2 ~p1  p0)

codigo_corregido[2] = codigo[2] ⊕ (~p2  p1 ~p0)

codigo_corregido[3] = codigo[3] ⊕ (~p2  p1  p0)

codigo_corregido[4] = codigo[4] ⊕ ( p2 ~p1 ~p0)

codigo_corregido[5] = codigo[5] ⊕ ( p2 ~p1  p0)

codigo_corregido[6] = codigo[6] ⊕ ( p2  p1 ~p0)

---

# Ecuaciones booleanas usadas para los 7-segmentos.

---

# Análisis de la simulación funcional del sistema completo.

[Simulación Funcional del Sistema Receptor](TB_top.sv)

El testbench tiene como objetivo verificar el correcto funcionamiento del módulo top. Inicialmente, se definen las señales de entrada (i3, i2, i1, c2, i0, c1, c0 y switch) y las salidas (posicion, codigo_corregido, led y segments), las cuales corresponden a las interfaces del diseño a prueba.

Seguidamente, se insta al módulo top con los parámetros DEBUG = 0 y DEBUG_SWITCH = 0, lo cual permite que el sistema utilice las entradas proporcionadas por el testbench en lugar de valores que deberían ser recolectados por la FPGA. De esta forma, el comportamiento del diseño simula el funcionamiento real.

Dentro del bloque initial, se inicia la prueba mostrando un mensaje y se aplica un estímulo de entrada asignando el vector de 7 bits 1111001  a las señales de entrada (código el cuál está sujeto a cambios por si se quiere probar otro código o otra posición de error), respetando el orden definido para el código de Hamming.

Ahora, el testbench muestra en consola el código recibido, la posición del error detectado y el código corregido, lo cual permite verificar la correcta operación de los módulos internos de detección y corrección de errores. Luego, se calcula y muestra la palabra corregida en formato binario extrayendo directamente los bits de información desde el código corregido.

Posteriormente, se evalúa el comportamiento del sistema dependiendo en la señal switch. Primero, se asigna un valor de 0, lo que corresponde a la visualización de la palabra en el display de 7 segmentos y se imprime el valor de la palabra en formato hexadecimal, verificando que la selección de datos hacia el display sea correcta. Por último, se asigna el nuevo valor del switch a 1, lo que indica que debe mostrarse la posición del error. 


---

# Análisis de consumo de recursos en la FPGA y del consumo de potencia.

---

# Problemas encontrados y soluciones aplicadas

Durante el desarrollo del proyecto, el grupo enfrentó varios problemas relacionados con la implementación y validación del sistema.
Uno de los principales inconvenientes fue la implementación inicial del código Hamming (7,4), donde se presentaron errores en los bits de paridad. Esto provocaba resultados incorrectos en el receptor. La solución fue revisar las ecuaciones teóricas y validar su funcionamiento mediante simulaciones antes de integrarlas.

También se presentaron dificultades en el cálculo del síndrome y en la corrección del error, ya que el sistema no identificaba correctamente la posición del bit erróneo. Para solucionarlo, se verificaron las ecuaciones del verificador de paridad y se implementó correctamente el decodificador del síndrome junto con la corrección mediante compuertas XOR en la programación de la FPGA.

En la visualización, se observaron inconsistencias en el display de 7 segmentos debido a errores en la lógica de decodificación. Esto se corrigió simplificando nuevamente las ecuaciones booleanas y revisando las conexiones físicas del display.

Finalmente, al trabajar en grupo de tres personas, surgieron dificultades al integrar los módulos desarrollados por separado. Para solucionarlo, se dividió el trabajo por subsistemas y se realizaron pruebas individuales antes de la integración final.

---


