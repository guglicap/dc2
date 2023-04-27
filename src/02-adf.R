source("src/02-build-df.R")

library(aTSA)

adf_raw <- df |>
    summarise(
        across(
           !data,
            ~ adf.test(.x, output = FALSE)$type1[,3][5]
        )
    )
