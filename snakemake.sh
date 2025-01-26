#!/bin/bash

#SBATCH -N 1            # number of nodes
#SBATCH -c 1            # number of cores 
#SBATCH -t 0-12:00:00   # time in d-hh:mm:ss
#SBATCH -p general      # partition 
#SBATCH -q public       # QOS
#SBATCH -o slurm.%j.out # file to save job's STDOUT (%j = JobId)
#SBATCH -e slurm.%j.err # file to save job's STDERR (%j = JobId)
#SBATCH --mail-type=ALL # Send an e-mail when a job starts, stops, or fails
#SBATCH --export=NONE   # Purge the job-submitting shell environment


module load mamba
source activate snakemake


snakemake --snakefile /data/stonelab/Kelly_TB/pipelines/snakemake-malt/Snakefile -j 20 --keep-target-files --keep-going --rerun-incomplete --latency-wait 30 --cluster "sbatch -N 1 -c {threads} -p general --mem={resources.mem} -t {params.time} -e /data/stonelab/Kelly_TB/malt/2025-01-16-TLT-preblast/slurm_outputs/slurm.%j.err -o /data/stonelab/Kelly_TB/malt/2025-01-16-TLT-preblast/slurm_outputs/slurm.%j.out"
#downgrading to v </= 5.26
#--wms-monitor http://data.evmed.asu.edu:5000
