for file in *.fasta; do
    outfile="${file%.fasta}.qnames.txt"
    sed -n 's/^>//p' "$file" > "$outfile"
done
