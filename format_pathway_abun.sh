#!/bin/bash

module purge
module load lefse/1.0

cd /work/biocore/zalsafwani/CRC_data/raw_reads/qiime2/second_analysis/picrust/run2/vis-lefse

# Get the path_abun_unstrat.tsv file
#cp ../results/pathways_out/path_abun_unstrat.tsv.gz
#gunzip path_abun_unstrat.tsv.gz

# Generate the sample list with conditions
cut ../../../metadata.tsv -f 1,2 > sample_list_type.tsv

# Get the correct format to run LEfSe
python pathway_format.py -i sample_list_type.tsv -r path_abun_unstrat.tsv -o path_abun_modified.tsv

lefse-format_input.py path_abun_modified.tsv path_abun_modified.in -c 1 -u 2 -o 1000000
run_lefse.py path_abun_modified.in path_abun_modified.res
lefse-plot_res.py path_abun_modified.res path_abun_modified.png --title 'Pathway abundance unstrat' --dpi 300 


