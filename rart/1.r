library(dplyr)
library(purrr)
library(tibble)
library(ggplot2)
library(ggthemes)
library(ambient)

seed <- 1234
epsilon <- 0.001
n <- 1000
frequency <- 20

x <- seq(from = 0, to = 1, length.out = n)
y <- seq(from = 0, to = 1, length.out = n)

canvas <- long_grid(x = x, y = y)

canvas <- (
  canvas
  %>% mutate(
    a = gen_checkerboard(x, y, frequency = frequency, seed = seed),
    b = gen_worley(y, x, frequency = frequency, seed = seed),
    c = gen_worley(x, y, frequency = frequency, seed = seed),
    d = ifelse(a, b, c)
    )
  )

(
  ggplot(canvas)
  + aes(
    x = x,
    y = y,
    fill = ifelse(a, d, -d)
    )
  + geom_raster()
  + theme_void()
  + theme(legend.position = "none")
  + coord_equal()
  + scale_x_continuous(expand = c(0, 0))
  + scale_y_continuous(expand = c(0, 0))
  + scale_fill_continuous(low = "steelblue2", high = "gold")
)

