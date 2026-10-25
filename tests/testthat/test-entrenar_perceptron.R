test_that("entrenar_perceptron devuelve la estructura esperada", {
  set.seed(123)
  X <- data.frame(horas = runif(100, 1, 10), asistencia = runif(100, 40, 100))
  y <- as.integer(2 * X$horas + 0.08 * X$asistencia >= 10)

  modelo <- entrenar_perceptron(X, y, epocas = 20, tasa = 0.01)

  expect_type(modelo, "list")
  expect_named(modelo, c("pesos", "sesgo", "medias", "desviaciones"))
  expect_length(modelo$pesos, 2)
  expect_length(modelo$medias, 2)
  expect_length(modelo$desviaciones, 2)
})

test_that("entrenar_perceptron maneja una variable constante", {
  X <- data.frame(a = c(1, 2, 3, 4), b = c(5, 5, 5, 5))
  y <- c(0, 0, 1, 1)

  modelo <- entrenar_perceptron(X, y, epocas = 10)

  expect_equal(unname(modelo$desviaciones["b"]), 1)
})
