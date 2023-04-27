source("src/03-detrend.R")

df <- df |>
    select(!starts_with("trend"))


library(RTransferEntropy)
library(future)
plan(multicore)

te <- tibble()
for (i in names(df)[6:7]) {
    for (j in names(df)[2:5]) {
        .te <- transfer_entropy(df[, j], df[, i], burn = 30, shuffles = 365)
        te <- te |>
            bind_rows(
                tibble(
                    factor = j,
                    pollutant = i,
                    ete =  .te$coef[1, 2],
                    p.value = .te$coef[1, 4]
                )
            )
    }
}
te

cor <- tibble()
for (i in names(df)[6:7]) {
    for (j in names(df)[2:5]) {
        .cor <- cor.test(x = df[, j, drop = TRUE], y = df[, i, drop = TRUE])
        cor <- cor |>
            bind_rows(
                tibble(
                    factor = j,
                    pollutant = i,
                    cor.coef =  .cor$estimate,
                    cor.p.value = .cor$p.value
                )
            )
    }
}
cor

influence <- full_join(te, cor, by = join_by(factor, pollutant))
