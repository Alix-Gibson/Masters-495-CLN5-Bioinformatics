# Raw Sequencing Data Quality Control

This directory contains quality-control results for the eight FASTQ files generated from the CRISPRi CLN5 i3N lysosomal screen.

## FastQC

FastQC was used to assess the quality of each sequencing file prior to downstream guide counting and analysis 

Eight FastQC HTML reports are provided, corresponding to four samples sequenced as paired-end reads:

- 21062D-07-01 — Upper lysosomal i3N population R1 forward reads and R2 reverse reads 
- 21062D-07-02 — Lower lysosomal i3N population R1 forward reads and R2 reverse reads 
- 21062D-07-03 — T0 iPSCs Undifferentiated control population R1 forward reads and R2 reverse reads 
- 21062D-07-04 — Day 7 Differentiated i3N population R1 and R2

The original FASTQ files are not included in this repository due to their large file size and are retained on the Aoraki HPC cluster.

## MultiQC

MultiQC was used to compile and summarise the FastQC results across all eight sequencing files to compare sequencing files

The `multiqc_report.html` file provides an interactive summary of sequencing quality metrics across the dataset.
