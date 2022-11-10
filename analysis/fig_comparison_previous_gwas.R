library(corrplot)
setwd("~/01_repos/CardiacGWAS/")
df = read.csv("~/01_repos/CardiacGWAS/results/log_p_assoc.csv", header=TRUE)
assocs = df[5:ncol(df)]

remove_loci = c("HFE*", "chr6_20", "chr6_24", "chr6_25", "chr6_28")

COMA_NAME <- "Best association (CoMA ensemble)"
colnames(assocs)[1] = COMA_NAME

assocs_mtx = as.matrix(assocs)
rownames(assocs_mtx) <- df$locus_name
assocs_mtx_capped = assocs_mtx

assocs_mtx_capped[assocs_mtx_capped > 15 ] = 15

THRESHOLD <- 9.5
assocs_mtx_capped <- assocs_mtx_capped[(!rownames(assocs_mtx_capped) %in% remove_loci) & assocs_mtx_capped[,COMA_NAME] > THRESHOLD,]

assocs_mtx_capped <- cbind(
  assocs_mtx_capped, 
  apply(assocs_mtx_capped[,colnames(assocs_mtx_capped) != COMA_NAME], 1, max)
) 
colnames(assocs_mtx_capped)[29] <- "Best association (other GWAS)"

MEYER_LVFD <- 14:22
MYGWAS <- 25:28
AUNG_PIRRUCELLO_LV <- 2:13
PIRRUCELLO_AORTA <- 23:24

cnames <- c(
  colnames(assocs_mtx_capped)[1], 
  colnames(assocs_mtx_capped)[29], 
  colnames(assocs_mtx_capped)[MYGWAS], 
  colnames(assocs_mtx_capped)[AUNG_PIRRUCELLO_LV], 
  sort(colnames(assocs_mtx_capped)[MEYER_LVFD]), 
  colnames(assocs_mtx_capped)[PIRRUCELLO_AORTA]
)

assocs_mtx_capped <- assocs_mtx_capped[, cnames]

FILENAME <- "manuscript/figs/gwas/previous_gwas.png"
png(FILENAME, width = 2000, height = 2200)

corrplot(
  t(assocs_mtx_capped),
  method="color",
  is.corr = FALSE, 
  tl.cex = 3, cl.cex = 3, tl.col = "black", tl.srt = 75, 
  #col = c(rev(COL1("Reds", 100)), COL1("Blues", 100)),
  col = COL2("RdBu", 200),
  addgrid.col = 'white',
  cl.pos = 'b'
)

dev.off()