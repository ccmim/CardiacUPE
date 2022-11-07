# Load latent representation
run_ids=c("2020-09-30_12-36-48", "2020-09-11_02-13-41")

# Load ICD10 code mappings
mapping_df <- read_tsv("data/ICD10_code_mapping.tsv")
mapping <- mapping_df$meaning
names(mapping) <- mapping_df$coding

# Load individuals with different diseases
icd10_dir <- "data/datasets/ids/icd10"
disease <- lapply(list.files(icd10_dir, full.names = T), readLines)
names(disease) <- sapply(list.files(icd10_dir), function(x) gsub("\\.txt", "", x))



# t-test

# for (run_id in run_ids) {
#   
#   
#     
# }