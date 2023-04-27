source("src/03-detrend.R")

.adf_detrend <- df |>
    summarise(
        across(
           !c(data, starts_with("trend")),
            ~ adf.test(.x, output = FALSE, nlag = 14)$type1[,3][13]
        )
    )
