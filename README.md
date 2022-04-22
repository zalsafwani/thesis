# A pipeline for reproducible human 16S rRNA microbiome analysis

## The main goal of this project is to establish feasibility of creating a reproducible pipeline from existing 16S rRNA microbiome sequencing data in humans by providing a full documented pipeline. 
- The first aim of this project is to identify challenges and gaps in 16S rRNA microbiome analysis by conducting a literature review. 
- The second aim of the project is to implement a full documented pipeline to reproduce 16S rRNA microbiome sequencing data analysis in humans. 
- The third aim of the project is to validate the reproducibility of the pipeline by running a public human dataset through it BioProject ID: PRJNA743150, and SRA Study: SRP326567.


## General overview of the pipeline.
![pipeline-overview](https://github.com/zalsafwani/thesis/blob/8e6ac6fc76ba5bdd8eb05fe4a7f484e132dc5429/Microbiome%20pipeline%20overview.png)
The first step is pre-processing the data with FastQC, MultiQC, then run QIIME2 to import the data, demux, and remove adapter (cutadapt). Running QIIME2 involv running DADA2, diversity analysis, phylogenetic analysis, and taxonomic analysis. The sub-analysis includes running two tools LEfSe and PICRUSt. The statistical analysis includes diversity alpha and beta group significant, and differential abundance (ANCOM). * (part1.slurm), ** (part2.slurm), and ***(part3.slurm).

## Tools installation and packages:
- SRAtoolkit version 2.11
- FastQC version 0.11
- MultiQC version py37/1.8
- QIIME2 version 2022.2
QIIME2 Plugins: cutadapt trim-paired, demux summarize, dada2 denoise-paired, metadata tabulate, feature-table filter-samples, feature-table summarize, feature-table tabulate-seqs, phylogeny align-to-tree-mafft-fasttree, feature-classifier classify-sklearn, taxa filter-table, taxa barplot, diversity core-metrics-phylogenetic, diversity pcoam, taxa collapse, feature-table relative-frequency, srs SRS, diversity alpha-group-significance, diversity beta-group-significance, composition add-pseudocount, and composition ancom.
- LEfSe version 1.0
- PICRUSt2 version 2.4
- R version 4.1.2 with 'tidyverse' and 'qiime2R' package.


## Detalied steps in how to run the pipeline is avalible in the steps.txt file.
Note that the full analysis could be run in Crane HOLLAND COMPUTING CENTER (HHC) without the need to install anything except for the step that create relative abundance plots (heatmap and barplot) which uses R and specific packages that are not available.

## License
This repo uses the GNU General Public License v 3.0.
