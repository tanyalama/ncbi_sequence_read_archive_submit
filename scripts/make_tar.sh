#! /bin/bash

#
#SBATCH --job-name=SRA
#SBATCH -o slurm-%j.out  # %j = job ID
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=1
#SBATCH --time=8:00:00
#SBATCH -p gpu

tar -zcvf SRA_SUB11032410_canada_lynx_wgs.tar.gz SRA_SUB11032410_canada_lynx_wgs/
