source("src/02-build-df.R")


df |>
    pivot_longer(
        cols = !data,
        names_to = "sensor",
        values_to = "value"
    ) |>
    group_by(sensor) |>
    reframe(
        data = data,
        value = value,
        trend = slide_dbl(
            .x = value,
            .f = ~ mean(.x, na.rm = TRUE),
            .before = 14,
            .after = 14
        )
    ) |>
    ggplot() +
    theme_bw() +
    theme(
        strip.text = element_text(size = 16),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size = 16),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 12),
    ) +
    facet_wrap(~sensor, ncol = 2, scales = "free_y") +
    geom_line(aes(x = data, y = trend), color = "#440b44") +
    geom_line(aes(x = data, y = value, color = sensor), alpha = 0.8, show.legend = FALSE) +
    scale_color_manual(
        values = c(
        palette[1],
        palette[2],
        palette[5],
        palette[6],
        palette[3],
        palette[4])
    )

ggsave("plots/series.pdf")
