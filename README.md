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

[Código del Transmisor](proyecto_1_transmisor__diseno)

### Subsistema de lectura y visualización
Este módulo recibe una palabra de 4 bits mediante interruptores y la muestra en un display de 7 segmentos en formato hexadecimal. Permite al usuario verificar el valor ingresado antes de la codificación.

### Codificador Hamming (7,4) y paridad par
Toma los 4 bits de entrada y genera una palabra de 7 bits agregando 3 bits de paridad. Estos bits se calculan mediante operaciones XOR para permitir la detección y corrección de errores en el receptor.

<p align="center">
<img width="526" height="516" alt="Codificador drawio" src="https://github.com/user-attachments/assets/107ccbf7-b4a5-409f-9383-ea4d98092acd" />
</p>

### Codificador de binario a 7 segmentos
Este módulo toma la palabra de 4 bits ingresada por el usuario, utiliza un conjunto de conmuntadores y mapas de Karnaugh para generar el display de 7 segmentos. Permite visualizar el valor en formato hexadecimal, facilitando la verificación del dato antes de ser procesado.

<p align="center">
<img width="321" height="91" alt="Codificador de binario a 7 segmentos drawio" src="https://github.com/user-attachments/assets/4c0f1fcf-caee-405c-9140-a7e266e2d99f" />
</p>

Aquí se muestra el resultado de la simplificación de Karnaugh para el segmento "c" del display de 7 segmentos.

B'C' + B'D + C'D + A'B + AB'

<p align="center">
<img width="3768" height="2764" alt="image" src="https://github.com/user-attachments/assets/66af0dd9-8cc4-4d2b-a2ea-b9bcf734ec53" />
</p>



### Generador de error
Recibe la palabra codificada de 7 bits y un valor de control de 3 bits que indica la posición del bit a alterar. Si se selecciona una posición válida, el módulo invierte ese bit, simulando un error en la transmisión.

<p align="center">
<img width="595" height="231" alt="Generador de error drawio" src="https://github.com/user-attachments/assets/d3504047-0cf6-4536-b7f2-8869b90ca5d4" />
</p>

### Salida del transmisor
La palabra codificada, con o sin error, se envía al receptor mediante conexiones físicas entre FPGAs.



## Receptor

[Código del Receptor](proyecto_1_receptor__diseno)

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

- seg₆ = i₃'i₂i₀ + i₃'i₁ + i₃i₂'i₁' + i₃i₀' + i₂'i₀' + i₂i₁
- seg₅ = i₂'i₁' + i₂'i₀' + i₃'i₁'i₀' + i₃'i₁i₀ + i₃i₁'i₀
- seg₄ = i₂'i₁' + i₂'i₀ + i₁'i₀ + i₃'i₂ + i₃i₂'
- seg₃ = i₃'i₁i₀' + i₃i₁' + i₂'i₁'i₀' + i₂'i₁i₀ + i₂i₁'i₀ + i₂i₁i₀'
- seg₂ = i₃i₂ + i₃i₁ + i₂'i₀' + i₁i₀'
- seg₁ = i₃'i₂i₁' + i₃i₂' + i₃i₁ + i₂i₀' + i₁'i₀'
- seg₀ = i₃'i₂i₁' + i₃i₂' + i₃i₀ + i₂'i₁ + i₁i₀'

---

# Análisis de la simulación funcional del sistema completo.

## Simulación Funcional del Transmisor
[Simulación Funcional del Sistema Transmisor](proyecto_1_transmisor__diseno/src/sim/transmitter_top_tb.sv)

El testbench tiene como objetivo verificar el correcto funcionamiento del módulo transmisor (transmitter_top), validando tanto la generación del código de Hamming con error como la salida hacia el display de 7 segmentos. Inicialmente, se definen las señales de entrada (datos y error_pos) y las salidas del sistema (hamming_error y seg), así como señales internas utilizadas para calcular los valores esperados, incluyendo el código de Hamming correcto, el código con error y la salida esperada del display.

Seguidamente, se instancia el módulo bajo prueba (DUT), conectando las señales definidas para permitir la evaluación directa de su comportamiento frente a distintos estímulos. Paralelamente, se implementa un modelo de referencia dentro del testbench mediante bloques always_comb, donde se calcula el código de Hamming (7,4) a partir de los bits de entrada, generando los bits de paridad correspondientes y construyendo la palabra codificada de 7 bits según la estructura definida.

A continuación, se modela la inyección de error, donde, dependiendo del valor de error_pos, se altera el bit correspondiente mediante una operación XOR con un desplazamiento, o se mantiene el código intacto en caso de no existir error. Asimismo, se implementa un modelo esperado para el display de 7 segmentos utilizando una estructura case, que asigna el patrón correspondiente a cada valor hexadecimal de entrada.

Dentro del bloque initial, se inicia la prueba mostrando un mensaje en consola y recorriendo exhaustivamente todas las combinaciones posibles de entrada. Para cada valor de datos (de 0 a 15), se evalúan todas las posiciones de error posibles (de 0 a 7), aplicando los estímulos y permitiendo un tiempo de estabilización antes de realizar las verificaciones.

Durante cada iteración, el testbench compara la salida del módulo con los valores esperados. En caso de discrepancias en el código de Hamming o en la salida del display, se reporta un error detallado indicando las condiciones de entrada y los valores obtenidos y esperados. Esto permite identificar fallos específicos en la lógica del diseño.

Finalmente, si todas las combinaciones son evaluadas sin errores, se muestra un mensaje indicando la correcta ejecución del test. Adicionalmente, se genera un archivo de forma de onda (.vcd) mediante las funciones $dumpfile y $dumpvars, lo que permite visualizar el comportamiento temporal de las señales y facilitar el análisis del sistema.

## Simulación Funcional del Receptor

[Simulación Funcional del Sistema Receptor](TB_top.sv)

El testbench tiene como objetivo verificar el correcto funcionamiento del módulo top. Inicialmente, se definen las señales de entrada (i3, i2, i1, c2, i0, c1, c0 y switch) y las salidas (posicion, codigo_corregido, led y segments), las cuales corresponden a las interfaces del diseño a prueba.

Seguidamente, se insta al módulo top con los parámetros DEBUG = 0 y DEBUG_SWITCH = 0, lo cual permite que el sistema utilice las entradas proporcionadas por el testbench en lugar de valores que deberían ser recolectados por la FPGA. De esta forma, el comportamiento del diseño simula el funcionamiento real.

Dentro del bloque initial, se inicia la prueba mostrando un mensaje y se aplica un estímulo de entrada asignando el vector de 7 bits 1111001  a las señales de entrada (código el cuál está sujeto a cambios por si se quiere probar otro código o otra posición de error), respetando el orden definido para el código de Hamming.

Ahora, el testbench muestra en consola el código recibido, la posición del error detectado y el código corregido, lo cual permite verificar la correcta operación de los módulos internos de detección y corrección de errores. Luego, se calcula y muestra la palabra corregida en formato binario extrayendo directamente los bits de información desde el código corregido.

Posteriormente, se evalúa el comportamiento del sistema dependiendo en la señal switch. Primero, se asigna un valor de 0, lo que corresponde a la visualización de la palabra en el display de 7 segmentos y se imprime el valor de la palabra en formato hexadecimal, verificando que la selección de datos hacia el display sea correcta. Por último, se asigna el nuevo valor del switch a 1, lo que indica que debe mostrarse la posición del error. 


---

# Análisis de consumo de recursos en la FPGA y del consumo de potencia.
## Recursos Para el transmisor
La herramienta reporta los siguientes datos:
- Number of wires:                 24
- Number of wire bits:            104
- Number of public wires:          24
- Number of public wire bits:     104
- Number of memories:               0
- Number of memory bits:            0
- Number of processes:              0
- Number of cells:                 51
  - ALU                             4
  - GND                             1
  - IBUF                            7
  - LUT2                            1
  - LUT3                            4
  - LUT4                           17
  - MUX2_LUT5                       2
  - OBUF                           14
  - VCC                             1

---

# Ejercicio 2: Oscilador en Anillo (Extra)

## Descripción general
El oscilador en anillo es un circuito formado por un número impar de inversores conectados en cascada, donde la salida del último inversor se retroalimenta a la entrada del primero de ellos. Esta configuración no tiene un estado estable, por lo que genera una señal oscilante de manera continua.
El funcionamiento del oscilador se basa en los retardos de propagación de cada inversor. Cuando una señal cambia de estado en la entrada, tarda un tiempo finito en reflejarse en la salida. Al propagarse a través de la cadena de inversores y regresar al inicio, se produce un ciclo de cambios que genera una señal periódica.

El periodo de oscilación depende directamente del número de inversores y del retardo de propagación de cada uno. En general, el periodo es proporcional al doble del número de inversores multiplicado por el retardo promedio de cada compuerta.

Este circuito permite medir experimentalmente parámetros importantes como el tiempo de propagación, así como observar efectos físicos como los tiempos de subida y bajada de la señal. Además, al modificar la longitud del circuito o agregar elementos adicionales, es posible analizar cómo estos factores afectan la frecuencia de oscilación.
El oscilador en anillo es una herramienta fundamental para comprender el comportamiento temporal de los circuitos digitales y las limitaciones físicas de las compuertas lógicas.

### Oscilador de 5 inversores
<p align="center">
<img width="688" height="148" alt="Oscilador5inv drawio" src="https://github.com/user-attachments/assets/c78cd96d-c12d-4d89-8a9c-0f8403d13878" />
</p>
<p align="center">
<img width="800" height="417" alt="an_5inv1" src="https://github.com/user-attachments/assets/b5b809ec-d6cb-4f64-8215-0d9a55db50a1" />

</p>

### Oscilador de 3 inversores
<p align="center">
<img width="425" height="148" alt="Oscilador3inv drawio" src="https://github.com/user-attachments/assets/72be091d-b024-44e0-9e97-2ff4282d3fc4" />
</p>
<p align="center">
<img width="800" height="419" alt="an_3iv3" src="https://github.com/user-attachments/assets/dd49e6ba-6ff8-4cbb-ba58-bc0b5521f04e" />
</p>
<p align="center">
<img width="800" height="414" alt="an_3iv2" src="https://github.com/user-attachments/assets/dc2e02c6-25f8-4a05-80e1-97443d0e6b7e" />

</p>

### Oscilador de 1 inversor
<p align="center">
<img width="165" height="251" alt="Oscilador1inv drawio" src="https://github.com/user-attachments/assets/5efaab38-f277-4bd8-a973-2203ec5d9234" />
</p>


## Relación entre la frecuencia de oscilación y el tiempo de retardo promedio

La frecuencia de oscilación de un oscilador en anillo está directamente determinada por el tiempo de retardo de propagación de los inversores que lo componen. Cada inversor introduce un retardo finito al cambiar su salida en respuesta a un cambio en la entrada.

Cuando una transición lógica recorre toda la cadena de inversores y regresa al punto inicial, se completa medio ciclo de la señal. Para completar un ciclo completo (de alto a bajo y de regreso a alto), la señal debe recorrer el circuito dos veces. Por esta razón, el periodo de oscilación depende del doble del número de inversores y del retardo de cada uno.

Matemáticamente, esta relación se expresa como:

$$
T = 2 \cdot N \cdot t_{pd}
$$

donde $$T$$ es el periodo, $$N$$ es el número de inversores y $$t_{pd}$$ es el retardo de propagación promedio.

Dado que la frecuencia es el inverso del periodo:

$$
f = \frac{1}{2 \cdot N \cdot t_{pd}}
$$

De esta expresión se observa que la frecuencia es inversamente proporcional al retardo de propagación. Esto implica que:

- Si el retardo de propagación aumenta, la frecuencia disminuye.
- Si el retardo de propagación disminuye, la frecuencia aumenta.

En términos físicos, esto ocurre porque un mayor retardo significa que la señal tarda más en propagarse a través del circuito, lo que alarga el periodo de oscilación. Por el contrario, inversores más rápidos permiten cambios más rápidos en la señal, aumentando la frecuencia.

Esta relación permite, a partir de la medición experimental del periodo o la frecuencia, estimar el retardo de propagación promedio de las compuertas utilizadas.


---
# Problemas encontrados y soluciones aplicadas

Durante el desarrollo del proyecto, el grupo enfrentó varios problemas relacionados con la implementación y validación del sistema.
Uno de los principales inconvenientes fue la implementación inicial del código Hamming (7,4), donde se presentaron errores en los bits de paridad. Esto provocaba resultados incorrectos en el receptor. La solución fue revisar las ecuaciones teóricas y validar su funcionamiento mediante simulaciones antes de integrarlas.

También se presentaron dificultades en el cálculo del síndrome y en la corrección del error, ya que el sistema no identificaba correctamente la posición del bit erróneo. Para solucionarlo, se verificaron las ecuaciones del verificador de paridad y se implementó correctamente el decodificador del síndrome junto con la corrección mediante compuertas XOR en la programación de la FPGA.

En la visualización, se observaron inconsistencias en el display de 7 segmentos debido a errores en la lógica de decodificación. Esto se corrigió simplificando nuevamente las ecuaciones booleanas y revisando las conexiones físicas del display.

Finalmente, al trabajar en grupo de tres personas, surgieron dificultades al integrar los módulos desarrollados por separado. Para solucionarlo, se dividió el trabajo por subsistemas y se realizaron pruebas individuales antes de la integración final.

---
# Bitácoras de trabajo

A continuación se adjuntan las bitácoras de trabajp de los 3 integrantes del grupo.

[Bitácora de trabajo: David Ignacio Araya Mora](bitacora-david-araya.pdf)

[Bitácora de trabajo: Nicolás Castro Sánchez](bitacora-nicolas-castro.pdf)

[Bitácora de trabajo: Sebastián Fallas Mora](Bitacora_P1_SebasFallasMora.pdf)

---



