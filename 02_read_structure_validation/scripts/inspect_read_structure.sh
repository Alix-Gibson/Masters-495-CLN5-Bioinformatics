
#!/bin/bash

# Read structure validation for CLN5 CRISPRi screen
#
# The purpose was to inspect paired-end FASTQ file reads to determine the location
#   of the sgRNA sequence and confirm the expected scaffold region.
# Read begins at 1 instead of 0 so 150bp paired end are numbered as 151 bp. 
#
# Final extraction coordinates:
#   R1: bases 82-120
#   R2: bases 63-101

echo "R1 READ STRUCTURE"

for f in *R1*.fastq.gz; do
    echo ""
    echo "$f"

    echo "Example sequences:"
    zcat "$f" | awk 'NR%4==2' | head -5

    echo -n "Reads containing forward scaffold: "
    zcat "$f" | awk 'NR%4==2' | grep -c "GTTTAAGAGCTAAGCTGGA"
done

echo ""
echo "R2 READ STRUCTURE"

for f in *R2*.fastq.gz; do
    echo ""
    echo "$f"

    echo "Example sequences:"
    zcat "$f" | awk 'NR%4==2' | head -5

    echo -n "Reads containing reverse scaffold: "
    zcat "$f" | awk 'NR%4==2' | grep -c "TCCAGCTTAGCTCTTAAAC"
done

echo ""
echo "FINAL EXTRACTION COORDINATES"
echo "R1: bases 82-120"
echo "R2: bases 63-101"
