NAY2019_columns= {
    "SNP": "SNP",
    "CHR": "CHR",
    "BP": "BP",
    "BETA": "BETA",
    "SE": "SE",
    "P": "P",
    "EA": "EA",
    "NEA": "NEA",
    "EAF": "EAF",
}

PIRRUCCELLO_LV2020_columns = {
    "SNP": "SNP",
    "CHR": "CHR",
    "BP": "BP",
    "BETA": "BETA",
    "SE": "SE",
    "A1FREQ": "EAF",
    "ALLELE1": "EA",
    "ALLELE1": "NEA",
    "P_BOLT_LMM": "P",
}

MEYER_2020_columns = {
    "chromosome": "CHR",
    "variant_id": "SNP",
    "base_pair_location": "BP",
    "other_allele": "NEA",
    "effect_allele": "EA",
    "effect_allele_frequency": "EAF",
    "beta": "BETA",
    "standard_error": "SE",
    "p_value": "P",
}

PIRRUCCELLO_aorta2022_columns = {
    "chromosome" : "CHR",
    "variant_id" : "SNP",
    "base_pair_location" : "BP",
    "other_allele" : "NEA",
    "effect_allele" : "EA",
    "effect_allele_frequency" : "EAF",
    "beta" : "BETA",
    "standard_error" : "SE",
    "p_value" : "P" 
}

MINE_columns = {
    "CHR": "CHR",
    "BP": "BP",
    "SNP": "SNP",
    "AF": "EAF",
    "a_0": "NEA",
    "a_1": "EA",
    "BETA": "BETA",
    "SE": "SE",
    "P": "P",    
}


GWAS_dict = {
    
    "Aung2019/AungN_31554410_LVMVR.txt": {
        "prefix": "NAY2019",
        "phenotype": "LVMVR",
        "columns": NAY2019_columns,
    },
    "Aung2019/AungN_31554410_LVEDV.txt": {
        "prefix": "NAY2019",
        "phenotype": "LVEDV",
        "columns": NAY2019_columns,
    },
    "Aung2019/AungN_31554410_LVM.txt": {
        "prefix": "NAY2019",
        "phenotype": "LVM",
        "columns": NAY2019_columns,
    },
    "Aung2019/AungN_31554410_LVEF.txt": {
        "prefix": "NAY2019",
        "phenotype": "LVEF",
        "columns": NAY2019_columns,
    },
    "Aung2019/AungN_31554410_LVESV.txt": {
        "prefix": "NAY2019",
        "phenotype": "LVESV",
        "columns": NAY2019_columns,
    },
    
    "Pirruccello2020_LV/MRI_lvedv_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "LVEDV",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    "Pirruccello2020_LV/MRI_lvedvi_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "LVEDVi",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    "Pirruccello2020_LV/MRI_lvesv_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "LVESV",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    "Pirruccello2020_LV/MRI_lvesvi_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "LVESVi",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    "Pirruccello2020_LV/MRI_lvef_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "LVEF",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    "Pirruccello2020_LV/MRI_sv_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "SV",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    "Pirruccello2020_LV/MRI_svi_filtered.tsv": {
        "prefix": "PIRRUCCELLO2020",
        "phenotype": "SVi",
        "columns": PIRRUCCELLO_LV2020_columns
    },
    
    'Meyer2020/GCST90000294_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice8",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000291_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice5",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000288_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice2",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000293_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice7",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000290_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice4",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000295_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice9",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000287_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice1",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000289_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice3",
        "columns": MEYER_2020_columns
    },
    'Meyer2020/GCST90000292_GRCh37.tsv': {
        "prefix": "MEYER2020",
        "phenotype": "LV_fractal_dim_slice6",
        "columns": MEYER_2020_columns
    },   
    'Pirruccello2022_Aorta/GCST90094400_buildGRCh37.tsv':     {
        "prefix": "PIRRUCCELLO2022",
        "phenotype": "Ascending thoracic aortic diameter",
        "columns": PIRRUCCELLO_aorta2022_columns
    }  , 
    'Pirruccello2022_Aorta/GCST90094401_buildGRCh37.tsv':   {
        "prefix": "PIRRUCCELLO2022",
        "phenotype": "Descending thoracic aortic diameter",
        "columns": PIRRUCCELLO_aorta2022_columns
    },
    'Mine/LVEDV.tsv':   {
        "prefix": "MyGWAS",
        "phenotype": "LVEDV",
        "columns": MINE_columns
    },     
    'Mine/LVSph.tsv':  {
        "prefix": "MyGWAS",
        "phenotype": "LVSph",
        "columns": MINE_columns
    } ,     
    'Mine/LVM.tsv':     {
        "prefix": "MyGWAS",
        "phenotype": "LVM",
        "columns": MINE_columns
    }  , 
    'Mine/RVEDV.tsv':   {
        "prefix": "MyGWAS",
        "phenotype": "RVEDV",
        "columns": MINE_columns
    }    
}
