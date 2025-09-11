while IFS=$'\t' read -r bam qnames || [ -n "$bam" ]; do
    base=$(basename "$bam" .bam)
    out="${base}.QNAMEfiltered.bam"
    samtools view -N "$qnames" -b "$bam" -o "$out"
done < bam_maltfasta_paths.tsv
