#!/bin/bash

# Alignment and library composition QC
#
# This script summarises guide-assigned reads from ScreenProcessing
# count files and calculates the proportion of reads assigned to:
#   1. the h1 Top5 library
#   2. the CLN5 guide
#   3. all other guides
#
# Usage:
#   ./alignment_library_QC.sh <counts_directory> <library_table> <output_file>

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <counts_directory> <library_table> <output_file>"
    exit 1
fi

COUNTS_DIR="$1"
LIBRARY_TABLE="$2"
OUTPUT="$3"

# Create temporary list of h1 Top5 guide IDs
H1_GUIDES=$(mktemp)

tail -n +2 "$LIBRARY_TABLE" | cut -f1 > "$H1_GUIDES"

# Output header
printf "Sample\tTotal_guide_assigned_reads\tH1_reads\tH1_percent\tCLN5_reads\tCLN5_percent\tOther_reads\tOther_percent\n" > "$OUTPUT"

# Process each count file
for f in "$COUNTS_DIR"/*.counts
do
    sample=$(basename "$f" .counts)

    # Total guide-assigned reads
    total=$(awk '{sum+=$2} END{print sum+0}' "$f")

    # Reads assigned to h1 Top5 guides
    h1=$(grep -Ff "$H1_GUIDES" "$f" | awk '{sum+=$2} END{print sum+0}')

    # Reads assigned to the CLN5 guide
    cln5=$(grep "^CLN5_+_77566620.23-P1P2" "$f" | awk '{sum+=$2} END{print sum+0}')

    # Remaining reads
    other=$((total-h1-cln5))

    # Percentages
    h1_pct=$(awk -v h="$h1" -v t="$total" 'BEGIN{printf "%.2f", 100*h/t}')
    cln5_pct=$(awk -v c="$cln5" -v t="$total" 'BEGIN{printf "%.2f", 100*c/t}')
    other_pct=$(awk -v o="$other" -v t="$total" 'BEGIN{printf "%.2f", 100*o/t}')

    printf "%s\t%d\t%d\t%s\t%d\t%s\t%d\t%s\n" \
        "$sample" "$total" "$h1" "$h1_pct" \
        "$cln5" "$cln5_pct" "$other" "$other_pct" \
        >> "$OUTPUT"
done

rm "$H1_GUIDES"

echo "QC complete."
echo "Results written to: $OUTPUT"
