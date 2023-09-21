# A pipeline for reproducible human 16S rRNA microbiome analysis

## The main goal of this project is to establish feasibility of creating a reproducible pipeline from existing 16S rRNA microbiome sequencing data in humans by providing a full documented pipeline. 
- The first aim of this project is to identify challenges and gaps in 16S rRNA microbiome analysis by conducting a literature review. 
- The second aim of the project is to implement a full documented pipeline to reproduce 16S rRNA microbiome sequencing data analysis in humans. 
- The third aim of the project is to validate the reproducibility of the pipeline by running a public human dataset through it BioProject ID: PRJNA743150, and SRA Study: SRP326567.


## General overview of the pipeline.
![pipeline-overview](https://github.com/zalsafwani/thesis/blob/621d1302af242417919a21142b0ac8aa846ecc04/Microbiome%20Analysis%20Pipeline.png)
The first step is pre-processing the data with FastQC, MultiQC, then run QIIME2 to import the data, demux, and remove adapter (cutadapt). Running QIIME2 involv running DADA2, diversity analysis, phylogenetic analysis, and taxonomic analysis. The sub-analysis includes running two tools LEfSe and PICRUSt. The statistical analysis includes diversity alpha and beta group significant, and differential abundance (ANCOM). * (part1.slurm), ** (part2.slurm), and ***(part3.slurm).

## Tools installation and packages:
- SRAtoolkit version 2.11
- FastQC version 0.11
- MultiQC version py37/1.8
- QIIME2 version 2021.4
QIIME2 Plugins: cutadapt trim-paired, demux summarize, dada2 denoise-paired, metadata tabulate, feature-table filter-samples, feature-table summarize, feature-table tabulate-seqs, phylogeny align-to-tree-mafft-fasttree, feature-classifier classify-sklearn, taxa filter-table, taxa barplot, diversity core-metrics-phylogenetic, diversity pcoam, taxa collapse, feature-table relative-frequency, srs SRS, diversity alpha-group-significance, diversity beta-group-significance, composition add-pseudocount, and composition ancom.
- LEfSe version 1.0
- PICRUSt2 version 2.4
- R version 4.1.2 with 'tidyverse' and 'qiime2R' package.


## Detailed steps in how to run the pipeline is available in the [steps file](https://github.com/zalsafwani/thesis/blob/f38aa88de88427e96d1d5a0974de9e8e4ffc7dbe/steps.md).
Note that the full analysis could be run in Crane HOLLAND COMPUTING CENTER (HHC) (https://hcc.unl.edu/) without the need to install anything except for the step that create relative abundance plots (heatmap and barplot) which uses R and specific packages that are not available.

## More information
Zahraa Wajih Alsafwani. A Pipeline for Reproducible Human 16S rRna Microbiome Analysis. University of Nebraska at Omaha ProQuest Dissertations Publishing, 2022. 29212761.


## License
This repo uses the GNU General Public License v 3.0.
