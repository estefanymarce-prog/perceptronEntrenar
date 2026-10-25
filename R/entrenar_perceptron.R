#' Entrenar un perceptron simple
#'
#' Entrena un perceptron simple para clasificacion binaria. Las variables
#' se estandarizan antes del entrenamiento y los pesos y el sesgo se
#' ajustan observacion por observacion en cada epoca.
#'
#' @param X Matriz o data frame con las variables predictoras (numericas).
#' @param y Vector de clases con valores 0 y 1.
#' @param epocas Numero de pasadas completas sobre los datos. Por defecto 100.
#' @param tasa Tasa de aprendizaje. Por defecto 0.01.
#'
#' @return Una lista con cuatro elementos: `pesos`, `sesgo`, `medias` y
#'   `desviaciones`. Las medias y desviaciones sirven para estandarizar
#'   datos nuevos al predecir.
#'
#' @importFrom stats sd
#' @export
#'
#' @examples
#' set.seed(123)
#' X <- data.frame(horas = runif(100, 1, 10), asistencia = runif(100, 40, 100))
#' y <- as.integer(2 * X$horas + 0.08 * X$asistencia >= 10)
#' modelo <- entrenar_perceptron(X, y, epocas = 50, tasa = 0.01)
#' modelo$pesos
entrenar_perceptron <- function(X, y, epocas = 100, tasa = 0.01) {
  X <- as.matrix(X)
  y <- as.numeric(y)

  # Estandarizar las variables
  medias <- colMeans(X)
  desviaciones <- apply(X, 2, sd)
  desviaciones[desviaciones == 0] <- 1
  Xs <- scale(X, center = medias, scale = desviaciones)

  # Inicializar pesos y sesgo
  pesos <- rep(0, ncol(Xs))
  sesgo <- 0

  # Entrenamiento
  for (e in 1:epocas) {
    for (i in sample(seq_len(nrow(Xs)))) {
      z <- sum(Xs[i, ] * pesos) + sesgo
      pred <- as.integer(z >= 0)
      error <- y[i] - pred
      pesos <- pesos + tasa * error * Xs[i, ]
      sesgo <- sesgo + tasa * error
    }
  }

  list(
    pesos = pesos,
    sesgo = sesgo,
    medias = medias,
    desviaciones = desviaciones
  )
}
