library(ggplot2)

r1_dir <- "/projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/Processing_2nd_Attempt/R1_Analysis/step1/output/count_files"

r2_dir <- "/projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/Processing_2nd_Attempt/R2_Analysis/step1/output/count_files"

r1_files <- list.files(
    r1_dir,
    pattern = "\\.counts$",
    full.names = TRUE
)

r2_files <- list.files(
    r2_dir,
    pattern = "\\.counts$",
    full.names = TRUE
)

results <- data.frame()

for (r1_file in r1_files) {

    r1_name <- basename(r1_file)

    sample <- sub(
        "_R1_001.*$",
        "",
        r1_name
    )

    r2_file <- r2_files[
        grepl(
            paste0("^", sample, "_R2_001"),
            basename(r2_files)
        )
    ]

    if (length(r2_file) != 1) {
        warning(
            "Could not uniquely match: ",
            sample
        )
        next
    }

    r1 <- read.table(
        r1_file,
        header = FALSE,
        sep = "\t",
        col.names = c("sgRNA", "R1")
    )

    r2 <- read.table(
        r2_file,
        header = FALSE,
        sep = "\t",
        col.names = c("sgRNA", "R2")
    )

    dat <- merge(
        r1,
        r2,
        by = "sgRNA"
    )

    pearson <- cor(
        dat$R1,
        dat$R2,
        method = "pearson"
    )

    spearman <- cor(
        dat$R1,
        dat$R2,
        method = "spearman"
    )

    results <- rbind(
        results,
        data.frame(
            Sample = sample,
            Guides = nrow(dat),
            Pearson_r = pearson,
            Spearman_rho = spearman
        )
    )

    p <- ggplot(
        dat,
        aes(x = R1 + 1, y = R2 + 1)
    ) +
        geom_point(
            alpha = 0.4,
            size = 1
        ) +
        geom_smooth(
            method = "lm",
            se = FALSE
        ) +
        scale_x_log10() +
        scale_y_log10() +
        labs(
            title = paste(
                "R1 vs R2:",
                sample
            ),
            subtitle = paste0(
                "Pearson r = ",
                round(pearson, 3),
                " | Spearman ρ = ",
                round(spearman, 3)
            ),
            x = "R1 guide count",
            y = "R2 guide count"
        ) +
        theme_classic()

    ggsave(
        paste0(
            "R1_R2_concordance_",
            sample,
            ".png"
        ),
        p,
        width = 7,
        height = 6,
        dpi = 300
    )
}

print(results)

write.csv(
    results,
    "R1_R2_concordance_results.csv",
    row.names = FALSE
)
