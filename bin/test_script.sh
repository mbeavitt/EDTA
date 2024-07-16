#!/bin/bash

output_dir="."
data_dir="../data/test_data"
hash_check_dir="../hash_checks"

perl ../EDTA.pl \
    --genome ${data_dir}/genome.fa \
    --cds ${data_dir}/genome.cds.fa \
    --curatedlib ../database/rice7.0.0.liban \
    --exclude ${data_dir}/genome.exclude.bed \
    --overwrite 1 \
    --sensitive 1 \
    --anno 1 \
    --threads 10
   
cat genome.fa.mod.EDTA.TEanno.gff3 | \
    grep -v \#\#date | \
    sed -E 's/TE_[0-9]+/REMOVED/g' > \
    stripped.gff3

md5sum stripped.gff3 > ${hash_check_dir}/md5hash$(date +%y-%m-%dm%M).txt
