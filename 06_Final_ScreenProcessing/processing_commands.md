# Final ScreenProcessing: Recounting and Filtering Commands

These commands document the final ScreenProcessing workflow used for sgRNA recounting and filtering. Commands were executed from the `Final_ScreenProcessing/ScreenProcessing` working directory.

## 1. FASTQ trimming and sgRNA recounting

### R1

```bash
python GitHub/ScreenProcessing/fastqgz_to_counts.py -p 6 --trim_start 82 --trim_end 120 \
  GitHub/ScreenProcessing/library_reference/CRISPRi_v2_human.trim_1_39_forward.fa \
  R1/step1/output \
  R1/step1/output/*.fastq.gz
```

### R2

```bash
python GitHub/ScreenProcessing/fastqgz_to_counts.py -p 6 --trim_start 63 --trim_end 101 \
  GitHub/ScreenProcessing/library_reference/CRISPRi_v2_human.trim_1_39_reverse.fa \
  R2/step1/output \
  R2/step1/output/*.fastq.gz
```

## 2. ScreenProcessing

### R1

```bash
python GitHub/ScreenProcessing/process_experiments.py \
  R1/step2/experiment_config_file_R1.txt \
  GitHub/ScreenProcessing/library_tables/
```

### R2

```bash
python GitHub/ScreenProcessing/process_experiments.py \
  R2/step2/experiment_config_file_R2.txt \
  GitHub/ScreenProcessing/library_tables/
```

## 3. h1 Top5 and Diff ≥20 filtering

### R1

```bash
python R1/filter_h1_top5_Diff20.py
```

### R2

```bash
python R2/R2_filter_h1_top5_Diff20.py
```

## 4. Final outputs

The final workflow generated:

* sgRNA count files for R1 and R2
* h1 Top5-filtered count files
* Diff ≥20-filtered count files
* ScreenProcessing gene-, library-, phenotype- and count tables
* QC plots
* volcano plots

The final R1 and R2 outputs are retained in the corresponding `R1/` and `R2/` directories within this repository.
