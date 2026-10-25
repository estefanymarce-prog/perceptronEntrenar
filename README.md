# perceptronEntrenar

Este paquete entrena un perceptron simple para clasificacion binaria en R. Estandariza las variables y ajusta los pesos y el sesgo por epocas.

Es el primero de tres paquetes independientes: `perceptronEntrenar`, `perceptronPredecir` y `perceptronGraficar`.

## Instalacion

Puedes instalar la version de desarrollo desde GitHub con:

``` r
# install.packages("devtools")
devtools::install_github("estefanymarce-prog/perceptronEntrenar")
```

## Ejemplo

``` r
library(perceptronEntrenar)

set.seed(123)
X <- data.frame(horas = runif(100, 1, 10), asistencia = runif(100, 40, 100))
y <- as.integer(2 * X$horas + 0.08 * X$asistencia >= 10)

modelo <- entrenar_perceptron(X, y, epocas = 100, tasa = 0.01)
modelo
```

## Resultado

`entrenar_perceptron()` devuelve una lista con cuatro elementos:

- `pesos`: peso de cada variable.
- `sesgo`: termino de sesgo.
- `medias`: media de cada variable (para estandarizar datos nuevos).
- `desviaciones`: desviacion estandar de cada variable.
