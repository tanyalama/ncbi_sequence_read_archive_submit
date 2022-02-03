#! /bin/bash

#
#SBATCH --job-name=rclone_copy_novogene
#SBATCH -o slurm-%j.out  # %j = job ID
#SBATCH --ntasks-per-node=1
#SBATCH --nodes=1
#SBATCH --time=1:00:00
#SBATCH -p gpu

rclone copy "sbugoogledrive:project_canada_lynx_wgs/data_canada_lynx_wgs/cleancopy_novogene" ./cleancopy_novogene
