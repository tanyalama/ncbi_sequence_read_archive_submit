#! /bin/bash

#
#SBATCH --job-name=tcag
#SBATCH -o slurm-%j.out  # %j = job ID
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --time=0:60:00
#SBATCH -p gpu

rclone check ./cleancopy_novogene "sbugoogledrive:project_canada_lynx_wgs/data_canada_lynx_wgs/cleancopy_novogene" --one-way
