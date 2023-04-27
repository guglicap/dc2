library(tidyverse)

pm <- read_csv(
    "data/RW_20230425161306_96659/RW_20230425161306_96659_10273_1.csv",
    na = c("-999"),
    skip = 3,
) |>
    left_join(
        by = join_by(`Data/Ora`),
        read_csv(
            "data/RW_20230425161306_96659/RW_20230425161306_96659_10283_1.csv",
            na = c("-999"),
            skip = 3
        )
    )

names(pm) <- c("data", "PM10", "PM2.5")

pm <- pm |>
    mutate(PM10 = PM10 - PM2.5)
