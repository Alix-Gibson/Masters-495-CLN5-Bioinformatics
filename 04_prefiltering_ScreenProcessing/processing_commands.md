# Processing 2: ScreenProcessing Commands

These commands document the ScreenProcessing workflow used during the second processing attempt. Commands were executed from the `Processing_2nd_Attempt` working directory.

## 1. FASTQ trimming and sgRNA counting

### R1

```bash
python GitHub/ScreenProcessing/fastqgz_to_counts.py -p 6 --trim_start 82 --trim_end 120 \
  GitHub/ScreenProcessing/library_reference/CRISPRi_v2_human.trim_1_39_forward.fa \
  R1_Analysis/step1/output \
  R1_Analysis/step1/output/*.fastq.gz
```

### R2

```bash
python GitHub/ScreenProcessing/fastqgz_to_counts.py -p 6 --trim_start 63 --trim_end 101 \
  GitHub/ScreenProcessing/library_reference/CRISPRi_v2_human.trim_1_39_reverse.fa \
  R2_Analysis/step1/output \
  R2_Analysis/step1/output/*.fastq.gz
```

## 2. ScreenProcessing

### R1

```bash
python GitHub/ScreenProcessing/process_experiments.py \
  R1_Analysis/step2/experiment_config_file_R1.txt \
  GitHub/ScreenProcessing/library_tables/
```

### R2

```bash
python GitHub/ScreenProcessing/process_experiments.py \
  R2_Analysis/step2/experiment_config_file_R2.txt \
  GitHub/ScreenProcessing/library_tables/
```

## 3. Repository structure

The commands above were executed within the original `Processing_2nd_Attempt` working directory.

Following completion of the analysis, the relevant scripts, configuration files, reference files, count outputs and QC outputs were reorganised within the GitHub repository under:

```text
04_prefiltering_ScreenProcessing/
```

The paths shown in the commands above therefore represent the **original analysis directory structure used during Processing_2nd_Attempt**, rather than the reorganised GitHub repository structure.
