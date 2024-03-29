Tools installation and packages:
- SRAtoolkit version 2.11
- FastQC version 0.11
- MultiQC version py37/1.8
- QIIME2 version 2021.4 
- QIIME2 Plugins: 
    - cutadapt trim-paired (https://docs.qiime2.org/2022.2/plugins/available/cutadapt/trim-paired/)
    - demux summarize (https://docs.qiime2.org/2022.2/plugins/available/demux/summarize/)
    - dada2 denoise-paired (https://docs.qiime2.org/2022.2/plugins/available/dada2/denoise-paired/)
    - metadata tabulate (https://docs.qiime2.org/2022.2/plugins/available/metadata/tabulate/)
    - feature-table filter-samples (https://docs.qiime2.org/2022.2/plugins/available/feature-table/filter-samples/)
    - feature-table summarize (https://docs.qiime2.org/2022.2/plugins/available/feature-table/summarize/)
    - feature-table tabulate-seqs (https://docs.qiime2.org/2022.2/plugins/available/feature-table/tabulate-seqs/)
    - phylogeny align-to-tree-mafft-fasttree (https://docs.qiime2.org/2022.2/plugins/available/phylogeny/align-to-tree-mafft-fasttree/)
    - feature-classifier classify-sklearn (https://docs.qiime2.org/2022.2/plugins/available/feature-classifier/classify-sklearn/)
    - taxa filter-table (https://docs.qiime2.org/2022.2/plugins/available/taxa/filter-table/)
    - taxa barplot (https://docs.qiime2.org/2022.2/plugins/available/taxa/barplot/)
    - diversity core-metrics-phylogenetic (https://docs.qiime2.org/2022.2/plugins/available/diversity/core-metrics-phylogenetic/)
    - diversity pcoa (https://docs.qiime2.org/2022.2/plugins/available/diversity/pcoa/)
    - taxa collapse (https://docs.qiime2.org/2022.2/plugins/available/taxa/collapse/)
    - feature-table relative-frequency (https://docs.qiime2.org/2022.2/plugins/available/feature-table/relative-frequency/)
    - srs SRS (https://library.qiime2.org/plugins/q2-srs/31/)
    - diversity alpha-group-significance (https://docs.qiime2.org/2022.2/plugins/available/diversity/alpha-group-significance/)
    - diversity beta-group-significance (https://docs.qiime2.org/2022.2/plugins/available/diversity/beta-group-significance/)
    - composition add-pseudocount (https://docs.qiime2.org/2022.2/plugins/available/composition/add-pseudocount/)
    - composition ancom (https://docs.qiime2.org/2022.2/plugins/available/composition/ancom/)
- LEfSe version 1.0
- PICRUSt2 version 2.4
- R version 4.1.2
    - tidyverse package (https://www.tidyverse.org/packages/)
    - qiime2R package (https://github.com/jbisanz/qiime2R)


1. Get raw reads sequnces (fastq).
    - To get sequnces from NCBI Sequence Read Archive (SRA), use the get_fastq.sh
    - Before running the script, go to the SRA Run Selector (https://www.ncbi.nlm.nih.gov/Traces/study/)
    - Then put the Sequence Read Archive (SRA) BioProject ID as an accession
    - Next select the samples you want then downlowd the accession list and metadata for the selected samples
    - Check the accession list file and name it 'SRR_Acc_List.txt' and make sure to leave one new line in the end of the file. Once the file is created (each line have one accession number).
    - Finally, run the 'bash get_fastq.sh' in the directory you wish to get the sequnces.

2. Pre-prosses the data using FastQC and MultiQC.
    - To run the quality control using the FastQC 
    - First, run 'bash get_sample_name_dic.sh > sample_dic.txt' in order to get the sample list where each accession number separated by space
    - Second, copy the sample_dic.txt to the qc.slurm for the 'sample_name' variable 
    - Once the 'sample_name' variable contain all of the samples make dirctury called 'qc' and make a sub-dirctury called 'script_output'
    - Edit the paths in line 8, 9, and 20 then run qc.slurm

3. Run Qiime2 
    - Make dirctury called 'qiime2' and make sure QIIME2 version 2021.4 installed with all of the plugins listed above.
    - Bulid the manifest file using the 'manifest_builder.py' by specifiying -i acc_list_file -p path_to_the_raw_reads
    - Get the metadata.tsv in the right formate example is provided.
    - Get the latest relese for the refrence database (SILVA or Greengenes (GG)). 
    - Naive Bayes classifiers trained on: both Greengenes and Silva classifiers are available here: https://docs.qiime2.org/2020.6/data-resources/#taxonomy-classifiers-for-use-with-q2-feature-classifier 
    - Make sure these files are included in the 'qiime2' directory: metadata.tsv, manifest, and refrence database.
    - Part 1 before running 'part1.slurm' check the following: 
        * Edit the path in line 8, 9, and 20.
        * If your data contain adapter sequnces removed them using cutadapt line 35-40 (make sure to change line 37, and 38 with your adapter sequnces).
        * If your data dosen't contain adapter sequnces then comment out lines 35-44.
        * Finally, run the 'sbatch part1.slurm'
    - Part 2 before running 'part2.slurm' check the following: 
        * Edit the path in line 8, 9, and 28.
        * In addition, look at the demux visulasation in the artifacts directory to assign trimming and truncating values.
        * If adapter sequnces were removed, look at the 'paired-end-demux-trimmed.qzv'
        * If no adapter sequnces were removed, look at the 'demux.qzv' and replace line 33 with '--i-demultiplexed-seqs artifacts/demuxed-paired-end.qza'.
        * Assign values for the dada2 denoising step line 18-21.
        * Make sure edit and check the file name of the refrence database line 72.
        * Finally, run the 'sbatch part2.slurm'
    - Part 3 before running 'part3.slurm' check the following: 
        * Edit the path in line 8, 9, and 15.
        * Look at the Interactive Sample Detail for the 'table-viz.qzv' in the artifacts directory in order to assign sampling depth value.
        * Once a sampling depth value was chosen add it to line 29.
        * Make sure that there is no directory called 'core-metrics-results'.
        * Finally, run the 'sbatch part3.slurm'
    - Normalization using SRS (scaling with ranked subsampling) method:
        * First, download the amplicon sequence variant (ASV) or the operational taxonomic unit (OTU) found in the artifacts directory 'table.qza'. 
        * Second, upload the 'table.qza' to the SRS Shiny app (https://vitorheidrich.shinyapps.io/srsshinyapp/) in order to choose a sampling depth (Cmin) or the normalization cut-off value.
        * It is best to choose a Cmin which doesn’t result in eliminating so many samples.
        * Once a Cmin value was chosen add it to line 7 in the 'normalized_srs.sh' script.
        * Finally, run the 'bash normalized_srs.sh' from the 'qiime2' directory.

4. Create relative abundance plots (heatmap and barplot)
    - First, install R version 4.1.2 and create a directory called 'qiime2_output'.
    - Second downlowd the 'Heatmap-barplot.R', 'metadata.tsv', 'table.qza', 'taxonomy.qza' to the 'qiime2_output' directory.
    - Edit the path in line 3 from the 'Heatmap-barplot.R' script.
    - Install both the 'tidyverse' package and the 'qiime2R' package.
    - Then run the rest of the code in the script.

5. Run sub-analysis: LEfSe, and PICRUSt2
    - LEfSe analysis steps:
        * First, install LEfSe version 1.0.
        * Make a sub-directory to the 'qiime2' called 'lefse'.
        * Go to the lefse directory 'cd lefse' and make sure both 'format_rel_level.sh' and 'rel_format.py' are available in the directory.
        * Before running the 'format_rel_level.sh' script make sure to the edit the title for the plots that will be created (line 28, 33, 38, 43, 48, and 53).
        * Finally, run the 'format_rel_level.sh'
    - PICRUSt2 analysis steps:
        * First, install PICRUSt2 version 2.4.
        * Make a sub-directory to the 'qiime2' called 'picrust'.
        * Go to the picrust directory 'cd picrust' and make sure 'picrust2.slurm', 'format_pathway_abun.sh' and 'pathway_format.py' are available in the directory.
        * Before running the 'picrust2.slurm' script make sure to the edit the path in line 8, 9, and 13.
        * Once the scripted finish create a directory called 'vis-lefse', 'cd vis-lefse' and make sure both 'format_pathway_abun.sh', and 'pathway_format.py' are available in the directory.
        * The 'format_pathway_abun.sh' is used to create a visualization for PICRUSt abundance pathway.
        * Before running the 'format_pathway_abun.sh' script make sure to the edit the path in line 6 and line 20 which contain the title for the plot.
        * Finally, run the 'format_pathway_abun.sh'.
        
6. Running correlation and statistical analysis: alpha and beta group significant, and differential abundance (ANCOM)
    - Alpha and beta group significant:
        * Make a sub-directory to the 'qiime2' called 'stat' and make sure it included 'stat.slurm' and a sub-dirctury called 'script_output'.
        * Before running the 'stat.slurm' edit the path in line 8, 9, and 15.
        * Change the '--m-metadata-column' for the beta-group-significance with your metadata column (line 44, 50, 56, 62, 68, 74, 81, and 87).
        * Finally, run the 'sbatch stat.slurm'
    - Differential abundance (ANCOM):
        * Make a sub-directory to the 'qiime2' called 'ancom' and make sure it included 'ancom.sh'.
        * Before running the 'ancom.sh' script edit the path in line 5.
        * Change the 'qiime composition ancom' functions with your metadata column (line 21, 39, 57, 74, 91, and 108).
        * Finally, run the 'bash ancom.sh'.
