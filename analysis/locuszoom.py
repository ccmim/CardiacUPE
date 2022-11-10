#!/usr/bin/env python
import os
import sys
import argparse
    
parser = argparse.ArgumentParser(description="Harmonise data, run GWAS and generate descriptive plots.")

parser.add_argument("--experiment_id", help="MLflow experiment ID", default="1")
parser.add_argument("--run_id", "-c", help="Mlflow run ID.", default="cc438c4acf664d5ab05ed79686968a06")
parser.add_argument("--z_variable", help="", default="z003") 
parser.add_argument("--phenotype", "-ph", nargs="+", default=None, help="")
parser.add_argument("--flank", default="25kb")
parser.add_argument("--gene", help="Gene name", default=None)
parser.add_argument("--variant", help="Variant", default=None)  # "rs11153730"
    
args = parser.parse_args()

# Find locuszoom binary. 
lzbin = os.path.abspath(os.path.join(os.environ["HOME"],"software/locuszoom/bin/locuszoom"));

exp_id = args.experiment_id
run_id = args.run_id
zvar = args.z_variable

locus = args.gene if args.gene is not None else args.variant
flank = args.flank

dirname = "CardiacCOMA/mlruns/%(exp_id)s/%(run_id)s/artifacts/GWAS_adj_10PCs" % {"exp_id": exp_id, "run_id": run_id}

gwas_file = "%(dirname)s/GWAS__%(zvar)s__%(exp_id)s_%(run_id)s.tsv %(zvar)s.tsv" % {"dirname": dirname, "zvar": zvar, "run_id": run_id, "exp_id": exp_id}
metal_file = "%(dirname)s/%(zvar)s_metal.tsv" % {"dirname": dirname, "zvar": zvar}
prefix = "%(dirname)s/locuszoom/%(zvar)s_%(locus)s" % {"dirname": dirname , "zvar": zvar, "locus": locus}

# CUT COMMAND
cut_cmd = "cut -f2,10 %(gwas_file)s > %(metal_file)s" % {"gwas_file": gwas_file, "metal_file": metal_file}

# LOCUSZOOM COMMAND
cmd = "%(bin)s"
cmd += " --metal %(metal_file)s"

if args.gene is not None:
    cmd += " --refgene %s" % locus
elif args.variant is not None:
    cmd += " --refsnp %s" % locus

cmd += " --build hg19"
cmd += " --pop EUR"
cmd += " --source 1000G_March2012"
cmd += " --flank %(flank)s"
cmd += " --markercol SNP --pvalcol P"
cmd += " --gwas-cat whole-cat_significant-only" 
cmd += " --prefix %(prefix)s"
cmd = cmd % {'bin' : lzbin, 'metal_file': metal_file, 'flank': flank, 'prefix': prefix};

if not os.path.exists(metal_file):
    print "Running: %s" % cut_cmd;
    os.system(cut_cmd); 
else:
    print "File %s already exists. Skipping 'cut' command..." % metal_file;

print "Running: %s" % cmd;
os.system(cmd); 
    
from glob import glob
pdf_file = glob("%s*/*pdf" % prefix)[0]
png_file = "%s/locuszoom/%s_%s_%s" % (dirname, zvar, locus, flank)
to_png_cmd = "pdftoppm %s %s -png -f 0 -singlefile" % (pdf_file, png_file)

# print("Found this PDF file: %s" % pdf_file) 
print "Running %s" % to_png_cmd
os.system(to_png_cmd)
