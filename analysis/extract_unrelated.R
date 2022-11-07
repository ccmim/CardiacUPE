library(dplyr)

all_ids <- as.integer(list.files("/home/rodrigo/doctorado/data/meshes/Results"))

KINSHIP_FILE <- "~/doctorado/data/UKBB/ukb11350_rel_s488282.dat"
kinship_df <- read.delim(KINSHIP_FILE, sep=reader::get.delim(KINSHIP_FILE))
kinship_df <- kinship_df %>% filter((ID1 %in% all_ids) & (ID2 %in% all_ids))

# -------------------------------------------------------------------------


extract_unrelated <- function(all_ids, kinship_file=KINSHIP_FILE, mse=NULL) {
    
}