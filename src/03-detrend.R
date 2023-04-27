source("src/02-build-df.R")

mean_na <- function(x) {
    mean(x, na.rm = TRUE)
}

df <- df |>
    mutate(trend_wspeed = slide_dbl(
        .x = wspeed,
        .f = mean_na,
        .before = 14,
        .after = 14,
        .complete = FALSE
    )) |>
    mutate(wspeed = wspeed - trend_wspeed)

df <- df |>
    mutate(trend_irr = slide_dbl(
        .x = irr,
        .f = mean_na,
        .before = 14,
        .after = 14,
        .complete = FALSE
    )) |>
    mutate(irr = irr - trend_irr)

df <- df |>
    mutate(trend_PM10 = slide_dbl(
        .x = PM10,
        .f = mean_na,
        .before = 14,
        .after = 14,
        .complete = FALSE
    )) |>
    mutate(PM10 = PM10 - trend_PM10)

df <- df |>
    mutate(trend_PM2.5 = slide_dbl(
        .x = PM2.5,
        .f = mean_na,
        .before = 14,
        .after = 14,
        .complete = FALSE
    )) |>
    mutate(PM2.5 = PM2.5 - trend_PM2.5)

df <- df |>
    mutate(trend_hum = slide_dbl(
        .x = hum,
        .f = mean_na,
        .before = 14,
        .after = 14,
        .complete = FALSE
    )) |>
    mutate(hum = hum - trend_hum)
