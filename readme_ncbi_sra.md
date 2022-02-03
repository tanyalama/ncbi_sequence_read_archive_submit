---
title: 'Uploading raw reads to NCBI SRA database'
disqus: hackmd
---

Uploading raw reads to NCBI SRA database
===
By Tanya Lama

## Table of Contents

[TOC]

Note that you need to preload files if you are uploading files >10Gb in size or more than 300 files into a single archive

Files must be in a single folder

The folder can be gzippped or bzipped but not zipped

## Download canada lynx wgs data from Drive
Make sure you do this in a job or in an interactive session
We'll save it in /scratch/project_canada_lynx_wgs
`rclone copy "sbugoogledrive:project_canada_lynx_wgs/data_canada_lynx_wgs/cleancopy_novogene" ./cleancopy_novogene`

## Check the integrity of your data
`rclone check ./cleancopy_novogene "sbugoogledrive:project_canada_lynx_wgs/data_canada_lynx_wgs/cleancopy_novogene" --one-way`

## Do the same with cleancopy_tcag

## Merge all of our raw reads into a single folder called SRA_SUB11032410_canada_lynx_wgs

## create a gzipped tar 
`tar -zcvf SRA_SUB11032410_canada_lynx_wgs.tar.gz SRA_SUB11032410_canada_lynx_wgs/`

## Preload to SRA

## Create an NCBI account using your ORCid
https://www.ncbi.nlm.nih.gov/account/linkAccount/?back_url=https%3A%2F%2Fsubmit.ncbi.nlm.nih.gov%2Fsubs%2Fsra%2F&token=327044501

My account is tanyamlama@orcid

## Requirements
* Files can be compressed using gzip or bzip2, and may be submitted in a tar archive but archiving and/or compressing your files is not required. Do not use zip!
* All file names must be unique and not contain any sensitive information. File names as submitted appear publicly in the Google and AWS clouds.
* Each file must be listed in the SRA metadata table. If you are uploading a tar archive, list each file name, not the archive name.
* Use the preload option if you are uploading files over 10 GB or more than 300 files. All files for a submission must be uploaded into a single folder. Please complete your submission within 30 days of creating a preload folder. If you upload files and do not submit them, they will be automatically deleted 30 days after folder creation.

## We will use the Aspera command line and FTP upload option

## Installing Aspera on Unity
1. Download the tar from: 
ibm.com/aspera/connect/
2. Transfer to /bin on Unity: 
scp /Users/tanya/Desktop/ibm-aspera-connect_4.1.1.73_linux.tar.gz tlama_umass_edu@unity.rc.umass.edu:/home/tlama_umass_edu/bin
3. tar xfvz ibm-aspera-connect_4.1.1.73_linux.tar.gz
4. chmod +x ibm-aspera-connect_4.1.0.46-linux_x86_64.sh
5. ./ibm-aspera-connect_4.1.0.46-linux_x86_64.sh
> Installing IBM Aspera Connect
Deploying IBM Aspera Connect (/home/tlama_umass_edu/.aspera/connect) for the current user only.
Unable to update desktop database, IBM Aspera Connect may not be able to auto-launch
Install complete.
6. Generate your aspera key
export PATH=$PATH:~/.aspera/connect/bin/
echo 'export PATH=$PATH:~/.aspera/connect/bin/' >> ~/.bash_profile
7. The path to your **private** key is now: 
/home/tlama_umass_edu/.aspera/connect/etc/asperaweb_id_dsa.openssh

## Module load Aspera on SharedCluster
/share/pkg/aspera/3.9.9/ibm-aspera-connect-3.9.9.177872-linux-g2.12-64.sh

## You may use the following command to upload files via Aspera Command-Line:
Usage is: 
`ascp -i <path/to/key_file> -QT -l100m -k1 -d <path/to/folder/containing files> subasp@upload.ncbi.nlm.nih.gov:uploads/tanya.m.lama_gmail.com_Z728gXCa`

`ascp -i /home/tlama_umass_edu/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l100m -k1 -d /home/tlama_umass_edu/scratch/project_canada_lynx_wgs/SRA_SUB11032410_canada_lynx_wgs.tar.gz subasp@upload.ncbi.nlm.nih.gov:uploads/tanya.m.lama_gmail.com_Z728gXCa`

Or you can sbatch ./sra_upload.sh

## Where:
<path/to/key_file> must be an absolute path, e.g.: /home/keys/aspera.openssh
<path/to/folder/containing files> needs to specify the local folder that contains all of the files to upload.

Get the key file.

If you upload your files in your root directory, you will not be able to see them or to select the folder during the submission.
Make a new subdirectory for each new submission. Your submission subfolder is a temporary holding area and it will be removed once the whole submission is complete.
Do not upload complex directory structures or files that do not contain sequence data.

Please complete your submission within 30 days of creating a preload folder. If you upload files and do not submit them, they will be automatically deleted 30 days after folder creation.

Return back to this page and click the "New submission" button to complete the submission.
Please note: it takes at least 10 minutes for uploaded files to become available for selection.

## Appendix and FAQ

:::info
**Find this document incomplete?** Leave a comment!
:::

###### tags: `tools` `scripts'
