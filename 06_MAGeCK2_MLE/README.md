# MAGeCK2-MLE Analysis

## Overview

MAGeCK2-MLE was used to estimate gene-level effects from the filtered CRISPRi screen count tables for sequencing runs R1 and R2.

The input count tables were generated following h1 Top5 library filtering and removal of sgRNAs with fewer than 20 reads in the Diff
 sample. These filtered count tables were then used as input for MAGeCK2-MLE.

The analyses were performed on the Aoraki HPC cluster using MAGeCK2.

## Experimental design

For both R1 and R2, the Diff sample was used as the baseline condition.

| Sample | baseline | Lower | Upper |
|---|---:|---:|---:|
| Diff | 1 | 0 | 0 |
| Lower | 1 | 1 | 0 |
| Upper | 1 | 0 | 1 |

This design estimates the effects of:

- Lower vs Diff
- Upper vs Diff

The same experimental design was used for both sequencing runs.

## Analysis settings

| Parameter | Setting |
|---|---|
| Analysis | MAGeCK2-MLE |
| Normalisation | Median |
| Threads | 8 |
| Baseline condition | Diff |
| Contrasts | Lower vs Diff; Upper vs Diff |
## R1 MAGeCK2-MLE

### Input files

The R1 analysis used:

- `R1_MAGECK_counts_Diff20_only.txt`
- `design_R1_Diff_baseline.txt`

### Command

The following command was recorded in the MAGeCK2 log:

```bash
/projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/mageck2/bin/mageck2 mle \
-k /projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/MAGeCK_MLE/MAGeCK2_R1/count/R1_MAGECK_counts_Diff20_only.txt \
-d /projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/MAGeCK_MLE/MAGeCK2_R1/design_R1_Diff_baseline.txt \
--norm-method median \
--threads 8 \
-n R1_MLE_Diff20_median
```

### Outputs

The R1 outputs retained in this repository are:

- `R1_MLE_Diff20_median.gene_summary.txt` — gene-level MLE results
- `R1_MLE_Diff20_median.log` — MAGeCK2 execution log

## R2 MAGeCK2-MLE

### Input files

The R2 analysis used:

- `R2_MAGECK_counts_Diff20_only.txt`
- `design_matrix_R2.txt`

### Command

The following command was recorded in the MAGeCK2 log:

```bash
/projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/mageck2/bin/mageck2 mle \
-k /projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/MAGeCK_MLE/MAGeCK2_R2/R2_MAGECK_counts_Diff20_only.txt \
-d /projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/MAGeCK_MLE/MAGeCK2_R2/design_matrix_R2.txt \
--norm-method median \
--threads 8 \
-n /projects/health_sciences/bms/biochemistry/hughes_lab/AlixGibson/MAGeCK_2/MAGeCK_MLE/MAGeCK2_R2/R2_MAGECK2_Diff20_median
```
### Outputs

The R2 outputs retained in this repository are:

- `R2_MAGECK2_Diff20_median.gene_summary.txt` — gene-level MLE results
- `R2_MAGECK2_Diff20_median.sgrna_summary.txt` — sgRNA-level MLE results
- `R2_MAGECK2_Diff20_median.log` — MAGeCK2 execution log

## Repository contents

```text
06_MAGeCK2_MLE/
├── README.md
├── R1/
│   ├── R1_MAGECK_counts_Diff20_only.txt
│   ├── design_R1_Diff_baseline.txt
│   ├── R1_MLE_Diff20_median.gene_summary.txt
│   └── R1_MLE_Diff20_median.log
└── R2/
    ├── R2_MAGECK_counts_Diff20_only.txt
    ├── design_matrix_R2.txt
    ├── R2_MAGECK2_Diff20_median.gene_summary.txt
    ├── R2_MAGECK2_Diff20_median.sgrna_summary.txt
    └── R2_MAGECK2_Diff20_median.log
```


