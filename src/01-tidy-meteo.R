library(tidyverse)

sensor_mapping <- read_csv("data/RW_20230425150804_545043/mapping.csv", na = c("", "-999")) |>
    select(Id_Sensore, Nome_Sensore)

meteo <- tibble()
for (f in Sys.glob("data/RW_20230425150804_545043/RW*.csv")) {
    .x <- read_csv(f, na = c("", "-999"))
    meteo <- meteo |> bind_rows(.x)
}


.wider_spec <- meteo |>
    rename(Id_Sensore = `Id Sensore`) |>
    left_join(sensor_mapping, by = join_by(Id_Sensore)) |>
    build_wider_spec(names_from = Nome_Sensore, values_from = Medio)
    # mutate(.value = ifelse(Nome_Sensore == "Precipitazione", "Valore Cumulato", .value))

meteo <- meteo |>
    rename(Id_Sensore = `Id Sensore`) |>
    left_join(sensor_mapping, by = join_by(Id_Sensore)) |>
    pivot_wider_spec(id_cols = `Data-Ora`, .wider_spec) |>
    # mutate(Precipitazione = Precipitazione[[1]]) |>
    rename_with(tolower) |>
    rename_with(~ gsub("\\s", "_", .x)) |>
    rename(data = `data-ora`) |>
    mutate(data = ymd_hm(data))

names(meteo) <- c("data", "temp", "hum", "precip", "w_dir", "irr", "w_speed")

palette <- viridis(6)

# meteo |>
#     write_csv(
#         "data/tidy-meteo.csv"
#     )
