# Read Structure Validation

## Purpose

The eight paired-end sequencing FASTQ files were inspected to determine the
location of the sgRNA sequence within the 150bp reads (read as 151).

Determing the location of sgRNA sequence was necessary to establish for trimming reads and counting sgRNAs

## Methods

Read sequences were inspected using command-line tools including
`zcat`, `awk`, and `grep`.

The expected CRISPRi scaffold sequences were used to identify the
position of the sgRNA relative to the scaffold and constant regions.

All four samples were examined in both forward (R1) and reverse (R2)
reads.

## Results

The read structure was consistent across the eight FASTQ files.

Coordinates for trimming were: 

R1: bases 82–120
R2: bases 63–101

## Files

### `scripts/`

`inspect_read_structure.sh` 
A cleaned command-line script for inspecting FASTQ read structure and
checking for the expected scaffold sequences.

### `results/`

`read_structure_summary.tsv`
A summary of the read structure site of sgRNA integration and trimming coordinates for all eight FASTQ files.
