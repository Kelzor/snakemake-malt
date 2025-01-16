##snakemake_running_malt <- cluster conda environment
import pandas as pd
units = pd.read_table("units.tsv", dtype=str, header=0, delim_whitespace=True).set_index(["sample"], drop=False)

def get_bams(wildcards):

    bams = units.loc[units['sample'] == wildcards.sample, ["bam"]].dropna(axis=1)
    bams_list = bams.values.tolist()

    return bams_list[0]

rule all:
    input:
        expand("rmas/{sample}.rma", sample = units.index.tolist())

rule bam_to_fastq:
    input:
        bam = get_bams
    output:
          temp("fastqs/{sample}.fastq")
    shell:
         "samtools fastq {input} > {output}"

rule fastq_gz:
    input:
        "fastqs/{sample}.fastq"
    output:
        "fastqs/{sample}.fastq.gz"
    shell:
        "gzip {input}"

rule malt:
    input:
         "fastqs/{sample}.fastq.gz"
    output:
        "rmas/{sample}.rma"
    shell:
        'malt-run --mode BlastN -at SemiGlobal --minPercentIdentity 95 --index /data/stonelab/metagenomic_databases/malt/mycobacteriaceae/index --output {output} --inFile {input}'
