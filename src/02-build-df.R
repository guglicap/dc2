source("src/01-tidy-meteo.R")
source("src/01-tidy-pm.R")

df <- meteo |>
    group_by(data = as_date(data)) |>
    summarise(
        wspeed = mean(w_speed, na.rm = TRUE),
        hum = mean(hum, na.rm = TRUE),
        irr = sum(irr, na.rm = TRUE),
        tot_precip = sum(precip, na.rm = TRUE),
    ) |>
    left_join(pm, by = join_by(data)) |>
    relocate(data, wspeed, hum, irr, tot_precip, PM10, PM2.5)
