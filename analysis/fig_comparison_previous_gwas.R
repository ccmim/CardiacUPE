library(corrplot)
setwd("~/01_repos/CardiacGWAS/")
df = read.csv("~/01_repos/CardiacGWAS/results/log_p_assoc.csv", header=TRUE)
assocs = df[5:ncol(df)]

remove_loci = c("chr6_24", "chr6_25", "chr6_28")

COMA_NAME <- "Best association (CoMA ensemble)"
colnames(assocs)[1] = COMA_NAME

assocs_mtx = as.matrix(assocs)
rownames(assocs_mtx) <- df$locus_name
assocs_mtx_capped = assocs_mtx

assocs_mtx_capped[assocs_mtx_capped > 12 ] = 12

THRESHOLD <- 9.5
assocs_mtx_capped <- assocs_mtx_capped[(!rownames(assocs_mtx_capped) %in% remove_loci) & assocs_mtx_capped[,COMA_NAME] > THRESHOLD,]

assocs_mtx_capped <- cbind(
  assocs_mtx_capped, 
  apply(assocs_mtx_capped[,colnames(assocs_mtx_capped) != COMA_NAME], 1, max)
) 
colnames(assocs_mtx_capped)[29] <- "Best association (other GWAS)"

cnames <- c(
  colnames(assocs_mtx_capped)[1], 
  colnames(assocs_mtx_capped)[29], 
  colnames(assocs_mtx_capped)[25:28], 
  colnames(assocs_mtx_capped)[2:13], 
  sort(colnames(assocs_mtx_capped)[14:22]), 
  colnames(assocs_mtx_capped)[23:24]
)

assocs_mtx_capped <- assocs_mtx_capped[, cnames]

FILENAME <- "manuscript/figs/gwas/previous_gwas.png"
png(FILENAME, width = 2000, height = 3000)

corrplot(
  t(assocs_mtx_capped), 
  is.corr = FALSE, 
  tl.cex = 2.5, cl.cex = 2.5, tl.col = "black", tl.srt = 75, 
  col = COL1("Blues", 200) 
)

dev.off()