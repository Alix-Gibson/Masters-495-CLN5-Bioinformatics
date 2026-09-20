#!/usr/bin/env python3

import pandas as pd
import os

# ==========================================================
# SETTINGS
# ==========================================================

count_dir = "R2/step1/output/count_files"

library_table = (
    "GitHub/ScreenProcessing/library_tables/"
    "CRISPRi_v2_human_librarytable.txt"
)

diff_file = "21062D-07-04_S105_L006_R2_001_CRISPRi_v2_human.trim_1_39_reverse.fa.counts"
lower_file = "21062D-07-02_S103_L006_R2_001_CRISPRi_v2_human.trim_1_39_reverse.fa.counts"
upper_file = "21062D-07-01_S102_L006_R2_001_CRISPRi_v2_human.trim_1_39_reverse.fa.counts"

threshold = 20

# ==========================================================
# LOAD LIBRARY TABLE
# ==========================================================

library = pd.read_csv(library_table, sep="\t")

# Keep ONLY the h1_top5 druggable library

library = library[
    library["sublibrary"] == "h1_top5"
]

print("--------------------------------------")
print("h1_top5 library")
print("--------------------------------------")
print("Guides :", len(library))
print("Genes  :", library["gene"].nunique())

# Keep list of sgRNAs

h1_guides = set(library["sgId"])

# ==========================================================
# READ COUNT FILES
# ==========================================================

def read_counts(filename):

    df = pd.read_csv(
        os.path.join(count_dir, filename),
        sep="\t",
        header=None,
        names=["sgRNA", "count"]
    )

    return df


diff = read_counts(diff_file)
lower = read_counts(lower_file)
upper = read_counts(upper_file)

# ==========================================================
# KEEP ONLY h1_top5 GUIDES
# ==========================================================

diff = diff[diff["sgRNA"].isin(h1_guides)]
lower = lower[lower["sgRNA"].isin(h1_guides)]
upper = upper[upper["sgRNA"].isin(h1_guides)]

print("\nAfter restricting to h1_top5 library")
print("Diff guides :", len(diff))
print("Lower guides:", len(lower))
print("Upper guides:", len(upper))

# ==========================================================
# APPLY Diff >=20 FILTER
# ==========================================================

diff_filtered = diff[diff["count"] >= threshold]

guides_to_keep = set(diff_filtered["sgRNA"])

lower_filtered = lower[
    lower["sgRNA"].isin(guides_to_keep)
]

upper_filtered = upper[
    upper["sgRNA"].isin(guides_to_keep)
]

print("\nAfter Diff >=20 filter")
print("Remaining guides :", len(diff_filtered))
print("Removed guides   :", len(diff) - len(diff_filtered))

# ==========================================================
# GENE SUMMARY
# ==========================================================

remaining_library = library[
    library["sgId"].isin(guides_to_keep)
]

guide_counts = remaining_library.groupby("gene").size()

print("\nRemaining genes :", guide_counts.index.nunique())

print("\nGuide distribution")

distribution = guide_counts.value_counts().sort_index()

for n, count in distribution.items():
    print(f"{n} guides : {count} genes")

print("\nGenes with >=3 guides :", (guide_counts >= 3).sum())
print("Genes with <3 guides  :", (guide_counts < 3).sum())

# ==========================================================
# SAVE FILES
# ==========================================================

diff_filtered.to_csv(
    os.path.join(
        count_dir,
        diff_file.replace(
            ".counts",
            "_h1_top5_Diff20.counts"
        )
    ),
    sep="\t",
    index=False,
    header=False
)

lower_filtered.to_csv(
    os.path.join(
        count_dir,
        lower_file.replace(
            ".counts",
            "_h1_top5_Diff20.counts"
        )
    ),
    sep="\t",
    index=False,
    header=False
)

upper_filtered.to_csv(
    os.path.join(
        count_dir,
        upper_file.replace(
            ".counts",
            "_h1_top5_Diff20.counts"
        )
    ),
    sep="\t",
    index=False,
    header=False
)

print("\n--------------------------------------")
print("Finished!")
print("--------------------------------------")

print("\nCreated:")

print(
    diff_file.replace(
        ".counts",
        "_h1_top5_Diff20.counts"
    )
)

print(
    lower_file.replace(
        ".counts",
        "_h1_top5_Diff20.counts"
    )
)

print(
    upper_file.replace(
        ".counts",
        "_h1_top5_Diff20.counts"
    )
)
