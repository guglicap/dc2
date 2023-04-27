source("src/05-calc-influence.R")

influence

influence |>
    mutate(p_str = sprintf("%.2f", p.value)) |>
    ggplot() +
    theme_bw() +
    theme(
        aspect.ratio = 1,
        strip.text = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        axis.title.x = element_blank(),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 16),
    ) +
    ylab("Influence [ETE]") +
    facet_wrap(~pollutant, nrow = 1) +
    geom_col(
        aes(
            x = factor, y = ete,
            fill = factor,
            alpha = ifelse(p.value < 0.05, 1, 0.2)
        ),
        show.legend = FALSE
    ) +
    geom_label(aes(x = factor, y = 0.002, label = glue("p = {p_str}")), size = 6) +
    scale_fill_manual(values = palette[1:4])

ggsave("plots/influence.pdf")
