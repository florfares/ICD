# Formato TIDY debe cumplir con tres condiciones:
# 1) una observacion por fila
# 2) un valor por celda
# 3) una variable por columna

# pero esto podria estar condicionado a la unidad de medida.

#Tipos de variables
# int, float, date/datetime/time, string, bool,

#variables factores/categoricas se caracterizan por:
# toman una cantidad de valores finito
# forman categorias,
# potencialmente pueden servir tanto numericas como strings.

## Directorio
getwd()
setwd("C:/Users/fares/OneDrive - Universidad Nacional de San Martin/LCD/ICD/01_Datos")
getwd()
####################################################### GUIA 1
library(tidyverse)

# 4. Cargar datos

data <- read_csv('properati_SM_SPA.csv')

# para saber que tipo de archivo es
class(data)

# 5.
#para que me abra el df
view(data)

# atajo para correr codigo: ctrl + enter
# atajo para comentar codigo: ctrl+shift+c
# atajo para escribir el asignador: alt+-

# ¿Cuál es la unidad de este conjunto de datos?
# son anuncios con las casas y departamentos a la venta en el partido de San Martín para un periodo especifico

# para obtener info del dataset tambien se puede usar el help 
help(iris)

#6.
glimpse(data)

# view permite ver todos los datos, mientras que glipmse permite un vistazo, es decir, a los primeros datos ordenados por lineas separadas por comas.
# ambos permiten identificar el nombre de las variables, mientras que glipmse ademas identifica el tipo y muestra la info de manera mas compacta,


# filas= 2173
# columnas: 26
# las numericas son las dbl, hay string, date, boolean,
# categoricas: moneda, tipo_propiedad, tipo_operac

# 7. l4 son las localidades
unique(data["l4"])
# o algo similar
distinct(select(data, l4))

# que tipo de elemento devuelven los comandos? una tibble?
class(unique(data["l4"]))
# o algo similar
class(distinct(select(data, l4)))

#ver cuantos anuncios hay para cada categoria de l4
count(data, l4)
# 1 Barrio Parque General San Martin    23
# 2 Billinghurst                        34
# 3 Ciudad Del Libertador                1
# 4 Jose Leon Suarez                   135
# 5 San Andres                         224
# 6 San Martín                         303
# 7 Villa Ballester                    927
# 8 Villa Bonich                        19
# 9 Villa Granaderos De San Martin       1
# 10 Villa Libertad                      19
# 11 Villa Lynch                         58
# 12 Villa Maipu                         46
# 13 NA                                 383

# 8. cuantos anuncios de dptos y casas en el dataset
count(data, tipo_propiedad)
# 1 Casa             871
# 2 Departamento    1302

# 9. En principio esperaria a que a mayor superficie, mayor sea el precio de la propiedad.
# 10.
ggplot(data, aes(x=sup_cubierta, y=precio)) +
  geom_point() +
  xlab("Superficie cubierta [m2]") +
  ylab("Precio [USD]")
# para mi hay bastante dispersion en los datos.
# 11 y 12. se necesitarian dos variables, precio y superficie. Cada punto representa un par ordenado de las variables precio y superficie.
# 13. la relacion es creciente, pero a medida que aumenta la superficie la dispersion de precios parece ser mayor.
# 14. agregar 14 como categorica
ggplot(data, aes(x=sup_cubierta, y=precio, color=l4)) +
  geom_point() +
  xlab("Superficie cubierta [m2]") +
  ylab("Precio [USD]")

ggplot(data, aes(x=sup_cubierta, y=precio, color=tipo_propiedad)) +
  geom_point() +
  xlab("Superficie cubierta [m2]") +
  ylab("Precio [USD]")

# recta ajustada a los datos
ggplot(data, aes(x=sup_cubierta, y=precio)) +
  geom_point() +
  geom_smooth(method='lm') +
  xlab("Superficie cubierta [m2]") +
  ylab("Precio [USD]")

ggplot(data, aes(x=sup_cubierta, y=precio, color=tipo_propiedad)) +
  geom_point() +
  geom_smooth(method='lm') +
  xlab("Superficie cubierta [m2]") +
  ylab("Precio [USD]")

# en el caso de los dptos, el precio incrementa mas rapido que para las casas. 
# Puede ser que los dptos esten ubicados en zonas mas centricas (donde hay edificios) 
# y, por lo tanto, que el mt cuadrado sea mas caro por la prestacion de servicios que 
# representa vivir en zonas centricas.

#17.
#cargar dataset citiesdf
load(file="citiesdf.rdata")

#a) nro de filas/observaciones (en la medida en que sea un tidy-data)
count(data)

#b) nro de columnas/variables/caracteristicas/dimensiones (en la medida en que sea un tidy-data)
length(data)

# hay 44 observaciones y 14 variables.
glimpse(data)


#c) las unidades son las ciudades recabadas para saber cuales tienen la mejor calidad de vida.
#d) y e) todas son numericas menos ciudad, continente, pais, idioma que son string (texto)

#18. ciudad: 44 ciudades, pais: 31 paises, idioma: 22 idiomas, continente: (1,2,3,4,5) continentes
unique(data$continente)
length(unique(data$idioma))
length(unique(data$pais))
# las variables float son costo_agua, nivel_felicidad, costo_gimnasio, nivel_felicidad, nivel_obesidad, expectativa_vida, indice_polucion
# creo que, potencialmente, todas las variables float pueden ser continuas.
# las variables numericas son continuas

#19. relacionar horas_sol con niveles de felicidad. Porque la falta de sol afecta el animo atraves de la deficiencia de vitamina D
ggplot(data, aes(x=horas_sol, y=nivel_felicidad)) +
  geom_point() +
  xlab("Horas de sol anuales") +
  ylab("Nivel de felicidad reportado")

#tambien se podria relacionar el nivel de polucion o nivel de obesidad con expectativa de vida

#para mi esta mas o menos bien en temas de ejes, pero megustaria verlo colorado pr continente.

ggplot(data, aes(x=horas_sol, y=nivel_felicidad, color=factor(continente))) +
  geom_point() +
  xlab("Horas de sol anuales") +
  ylab("Nivel de felicidad reportado")

# 20, 21, 22, 23
ggplot(data, aes(x=indice_polución, y=expectativa_vida, color=factor(continente))) +
  geom_point() +
  xlab("Indice polución") +
  ylab("Expectativa de vida")


ggplot(data, aes(x=nivel_obesidad, y=expectativa_vida, color=factor(continente))) +
  geom_point() +
  xlab("Nivel de obesidad") +
  ylab("Expectativa de vida")

#En general, los paises mas ricos, generalmente los europeos, es donde parecen estar los mejores indicadores.
# Noto que en algunos casos del graf obesidad vs expec de vida, hay algunos continentes con muchas mas observaciones, 
# y en algunos casos las obs estan mas concentradas en ciertas areas del grafico, y en otros parece que hay más outliers.
# la asociacion entre polucion y expectativa de vida, nuevamente, cuanto menor la polucion mayor exp de vida, 
# aunque no es tan clara esa asociación filtrando por continentes. 
# El ajuste podría no ser lineal, sino que luego de un umbral de polución la expectativa de vida 
# cae más rapido con cada incremento del indice de polución
# la agrupacion que usaria es la de continentes.