# Cardiac GWAS

### Contents

This repository contains the code for the paper _Unsupervised ensemble-based phenotyping helps enhance the discoverability of genes related to heart morphology_.

It contains two main Git submodules:  1) `CardiacCOMA` and 2) `GWAS_pipeline`.
1) implements the convolutional mesh autoencoder (CoMA). It performs the training of the network and, importantly, produces the $\textbf{z}$ latent vectors that are used as phenotypes in the subsequent GWAS. The network is implemented in `pyTorch` and `pytorch-lightning`. All run data is logged as artifacts using MLflow.
2) contains the code to perform data pre-processing for GWAS, GWAS execution and results visualization. This repository is written in R and Python. Also, several bash scripts that invoke different command-line bioinformatic tools.

Additional submodules are: 3) `CardioMesh` for cardiac 3D mesh processing, 4) `UKBB_helpers` for pre-processing UKBB data and 5) `SGE_helpers` for assisting with job distribution in an HPC using the `Son of Grid Engine` queue management system (in this case, University of Leeds' ARC).

This root repository contains code for performing MLflow queries to collect the GWAS summary statistics for differern CoMA runs into an ensemble of genetic associations for each locus. It also contains code to produce the different results figures of the paper, and to produce `LaTex` code for the different tables of results.

Finally, it contains a folder called `shiny` with source code of a R Shiny web application that allows to explore extensively the full set of results generated for this work.

### Pipeline

Pipeline of the work conducted in this repository:

```mermaid
graph TD
%% Top Node
id1(BGEN Genotypes)
id4(CMR-derived meshes)
id3(Metadata)
id2(PLINK Genotypes)


%% Summary quantities
id1.1(MAF)
id1.2(HWE p-value)
id1.3(INFO score)
id1.4(Missingness rate)
id1.5(Relatedness)

%% Metadata items
id3.1(Ethnicity)
id3.2(Height, BMI, Sex, Age, S/DBP, etc.)

id3.2.1(Height, BMI, Sex, Age, S/DBP, etc. pre-processed)

%% Types Of Media
id1.1.1(Filtered BGEN genotypes)

id1 --> id1.1 & id1.2 & id1.3 & id1.4 & id1.5
id1.1 -- >1% --> id1.1.1
id1.2 -- >0.0001 --> id1.1.1
id1.3 -- >0.3 --> id1.1.1
id1.4 --> id1.1.1
id1.5 -->  id1.1.1

%% Genomic PCs
id2.1(Genomic PCs)
id2 --> id2.1

%% 
id3 -->  id3.1
id3 -->  id3.2
id3.1 -- GBR -->  id1.1.1

%% z vector
id4.1( z vector)
id4.1.1( adjusted z vector)

id3.2 --> id3.2.1
id4 -- mesh-VAE --> id4.1
id4.1 --> id4.1.1
id2.1 --> id4.1.1
id3.2.1 --> id4.1.1

%% GWAS summary statistics
id5(GWAS summary statistics)
id1.1.1 -- GWAS --> id5
id4.1.1 -- GWAS --> id5

id5.1(Manhattan & QQ plots)
id5.2(Gene-level summary statistics)
id5.3(Heritability)

id5 -- qqman --> id5.1
id5 -- SPrediXcan --> id5.2
id5 -- BOLT-LMM --> id5.3
```
