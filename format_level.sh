#!/bin/bash

# Get the phyla_table_rel_level files
cp ../exports/table/feature-table-w-taxa.tsv .

# Generate the sample list with conditions
cut ../metadata.tsv -f 1,2 > sample_list_type.tsv

# Get the correct format to run LEfSe
python rel_format.py -i sample_list_type.tsv -r feature-table-w-taxa.tsv -o feature-table-w-taxa-formated.tsv

module purge
module load lefse/1.0

lefse-format_input.py feature-table-w-taxa-formated.tsv feature-table-w-taxa-formated.in -c 1 -u 2 -o 1000000
run_lefse.py feature-table-w-taxa-formated.in feature-table-w-taxa-formated.res
lefse-plot_cladogram.py feature-table-w-taxa-formated.res feature-table-w-taxa-cladogram.png --format png
