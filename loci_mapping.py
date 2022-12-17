
LOCUS_TO_REGION = {
  "GOSR2": "chr17_27", 
  "TTN": "chr2_108", 
  "PLN": "chr6_78", 
  "TBX5": "chr12_69",
  "CHTOP*": "chr1_124",
  "CREBRF*": "chr5_103",
  "EN1*": "chr2_69",
  "STRN": "chr2_23",
  "BAG3": "chr10_74",
  "LMO7": "chr13_37",
  "RBM20": "chr10_69",
  "CCDC91*": "chr12_19",
  "OR9Q1": "chr11_32",  
  "LSP1*": "chr11_2", 
  "ATXN2*": "chr12_67",
  "NCSTNP1*": "chr21_10",
  "chr6_84": "chr6_84",
  "chr3_63": "chr3_63",
  "WAC": "chr10_20"
}

REGION_TO_LOCUS = {v:k for k, v in LOCUS_TO_REGION.items()}

LOCI_TO_DROP = [
    "chr6_79", 
    "chr6_20", 
    "chr6_24", 
    "chr6_25", 
    "chr6_26",
    "chr6_27",
    "chr6_28",
]