#! /bin/bash

#
#SBATCH --job-name=SRA
#SBATCH -o slurm-%j.out  # %j = job ID
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=1
#SBATCH --time=1:00:00
#SBATCH -p gpu

ascp -i /home/tlama_umass_edu/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l100m -k1 -d /home/tlama_umass_edu/scratch/project_canada_lynx_wgs/SRA_SUB11032410_canada_lynx_wgs.tar.gz subasp@upload.ncbi.nlm.nih.gov:uploads/tanya.m.lama_gmail.com_Z728gXCa
