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

## Success: 
Note that Aspera never registered the upload using a tar.gz
I suspect this is because it was not housed within it's own folder. Aspera needs you to direct it to a folder with a unique name
We had more success uploading an unzipped folder with 140 fasta files inside. 
The BioProject has been accessioned under **BioProject ID PRJNA803364**
The Samples have been accessioned under: 
Accession    Sample Name    SPUID    Organism    Tax ID    Breed   
SAMN25649240    BOBCAT_1    BOBCAT_1    Lynx rufus    61384    not applicable   
SAMN25649241    BOBCAT_2    BOBCAT_2    Lynx rufus    61384    not applicable   
SAMN25649242    BOBCAT_3    BOBCAT_3    Lynx rufus    61384    not applicable   
SAMN25649243    BOBCAT_4    BOBCAT_4    Lynx rufus    61384    not applicable   
SAMN25649244    BOBCAT_5    BOBCAT_5    Lynx rufus    61384    not applicable   
SAMN25649245    BOBCAT_6    BOBCAT_6    Lynx rufus    61384    not applicable   
SAMN25649246    L155    L155    Lynx canadensis    61383    not applicable   
SAMN25649247    LIC11    LIC11    Lynx canadensis    61383    not applicable   
SAMN25649248    LIC20    LIC20    Lynx canadensis    61383    not applicable   
SAMN25649249    LIC23    LIC23    Lynx canadensis    61383    not applicable   
SAMN25649250    LIC24    LIC24    Lynx canadensis    61383    not applicable   
SAMN25649251    LIC27B    LIC27B    Lynx canadensis    61383    not applicable   
SAMN25649252    LIC28    LIC28    Lynx canadensis    61383    not applicable   
SAMN25649253    LIC31    LIC31    Lynx canadensis    61383    not applicable   
SAMN25649254    LIC32    LIC32    Lynx canadensis    61383    not applicable   
SAMN25649255    LIC36    LIC36    Lynx canadensis    61383    not applicable   
SAMN25649256    LIC46    LIC46    Lynx canadensis    61383    not applicable   
SAMN25649257    LIC47    LIC47    Lynx canadensis    61383    not applicable   
SAMN25649258    LIC48    LIC48    Lynx canadensis    61383    not applicable   
SAMN25649259    LIC54    LIC54    Lynx canadensis    61383    not applicable   
SAMN25649260    LIC57    LIC57    Lynx canadensis    61383    not applicable   
SAMN25649261    LIC60    LIC60    Lynx canadensis    61383    not applicable   
SAMN25649262    LIC8    LIC8    Lynx canadensis    61383    not applicable   
SAMN25649263    LIC9    LIC9    Lynx canadensis    61383    not applicable   
SAMN25649264    LIT2    LIT2    Lynx canadensis    61383    not applicable   
SAMN25649265    LIT5    LIT5    Lynx canadensis    61383    not applicable   
SAMN25649266    LRK10    LRK10    Lynx canadensis    61383    not applicable   
SAMN25649267    LRK11    LRK11    Lynx canadensis    61383    not applicable   
SAMN25649268    LRK12    LRK12    Lynx canadensis    61383    not applicable   
SAMN25649269    LRK13    LRK13    Lynx canadensis    61383    not applicable   
SAMN25649270    LRK17    LRK17    Lynx canadensis    61383    not applicable   
SAMN25649271    LRK22    LRK22    Lynx canadensis    61383    not applicable   
SAMN25649272    ME1998    ME1998    Lynx canadensis    61383    not applicable   
SAMN25649273    a109    a109    Lynx canadensis    61383    not applicable   
SAMN25649274    a182    a182    Lynx canadensis    61383    not applicable   
SAMN25649275    A202    A202    Lynx canadensis    61383    not applicable   
SAMN25649276    a33    a33    Lynx canadensis    61383    not applicable   
SAMN25649277    a475    a475    Lynx canadensis    61383    not applicable   
SAMN25649278    A494    A494    Lynx canadensis    61383    not applicable   
SAMN25649279    a507    a507    Lynx canadensis    61383    not applicable   
SAMN25649280    a697    a697    Lynx canadensis    61383    not applicable   
SAMN25649281    A772    A772    Lynx canadensis    61383    not applicable   
SAMN25649282    a794    a794    Lynx canadensis    61383    not applicable   
SAMN25649283    A803    A803    Lynx canadensis    61383    not applicable   
SAMN25649284    A818    A818    Lynx canadensis    61383    not applicable   
SAMN25649285    A857    A857    Lynx canadensis    61383    not applicable   
SAMN25649286    B114    B114    Lynx canadensis    61383    not applicable   
SAMN25649287    B124    B124    Lynx canadensis    61383    not applicable   
SAMN25649288    b188    b188    Lynx canadensis    61383    not applicable   
SAMN25649289    B23    B23    Lynx canadensis    61383    not applicable   
SAMN25649290    b276    b276    Lynx canadensis    61383    not applicable   
SAMN25649291    B554    B554    Lynx canadensis    61383    not applicable   
SAMN25649292    b90    b90    Lynx canadensis    61383    not applicable   
SAMN25649293    c165    c165    Lynx canadensis    61383    not applicable   
SAMN25649294    c323    c323    Lynx canadensis    61383    not applicable   
SAMN25649295    c548    c548    Lynx canadensis    61383    not applicable   
SAMN25649296    B13    B13    Lynx canadensis    61383    not applicable   
SAMN25649297    CB15    CB15    Lynx canadensis    61383    not applicable   
SAMN25649298    CB42    CB42    Lynx canadensis    61383    not applicable   
SAMN25649299    CB7    CB7    Lynx canadensis    61383    not applicable   
SAMN25649300    f264    f264    Lynx canadensis    61383    not applicable   
SAMN25649301    f457    f457    Lynx canadensis    61383    not applicable   
SAMN25649302    FHA_024    FHA_024    Lynx canadensis    61383    not applicable   
SAMN25649303    FHA_042    FHA_042    Lynx canadensis    61383    not applicable   
SAMN25649304    FHA_043    FHA_043    Lynx canadensis    61383    not applicable   
SAMN25649305    L09_003    L09_003    Lynx canadensis    61383    not applicable   
SAMN25649306    L09_007    L09_007    Lynx canadensis    61383    not applicable   
SAMN25649307    L09_015    L09_015    Lynx canadensis    61383    not applicable   


https://www.ncbi.nlm.nih.gov/biosample/25649240
https://www.ncbi.nlm.nih.gov/biosample/25649241
https://www.ncbi.nlm.nih.gov/biosample/25649242
https://www.ncbi.nlm.nih.gov/biosample/25649243
https://www.ncbi.nlm.nih.gov/biosample/25649244
https://www.ncbi.nlm.nih.gov/biosample/25649245
https://www.ncbi.nlm.nih.gov/biosample/25649246
https://www.ncbi.nlm.nih.gov/biosample/25649247
https://www.ncbi.nlm.nih.gov/biosample/25649248
https://www.ncbi.nlm.nih.gov/biosample/25649249
https://www.ncbi.nlm.nih.gov/biosample/25649250
https://www.ncbi.nlm.nih.gov/biosample/25649251
https://www.ncbi.nlm.nih.gov/biosample/25649252
https://www.ncbi.nlm.nih.gov/biosample/25649253
https://www.ncbi.nlm.nih.gov/biosample/25649254
https://www.ncbi.nlm.nih.gov/biosample/25649255
https://www.ncbi.nlm.nih.gov/biosample/25649256
https://www.ncbi.nlm.nih.gov/biosample/25649257
https://www.ncbi.nlm.nih.gov/biosample/25649258
https://www.ncbi.nlm.nih.gov/biosample/25649259
https://www.ncbi.nlm.nih.gov/biosample/25649260
https://www.ncbi.nlm.nih.gov/biosample/25649261
https://www.ncbi.nlm.nih.gov/biosample/25649262
https://www.ncbi.nlm.nih.gov/biosample/25649263
https://www.ncbi.nlm.nih.gov/biosample/25649264
https://www.ncbi.nlm.nih.gov/biosample/25649265
https://www.ncbi.nlm.nih.gov/biosample/25649266
https://www.ncbi.nlm.nih.gov/biosample/25649267
https://www.ncbi.nlm.nih.gov/biosample/25649268
https://www.ncbi.nlm.nih.gov/biosample/25649269
https://www.ncbi.nlm.nih.gov/biosample/25649270
https://www.ncbi.nlm.nih.gov/biosample/25649271
https://www.ncbi.nlm.nih.gov/biosample/25649272
https://www.ncbi.nlm.nih.gov/biosample/25649273
https://www.ncbi.nlm.nih.gov/biosample/25649274
https://www.ncbi.nlm.nih.gov/biosample/25649275
https://www.ncbi.nlm.nih.gov/biosample/25649276
https://www.ncbi.nlm.nih.gov/biosample/25649277
https://www.ncbi.nlm.nih.gov/biosample/25649278
https://www.ncbi.nlm.nih.gov/biosample/25649279
https://www.ncbi.nlm.nih.gov/biosample/25649280
https://www.ncbi.nlm.nih.gov/biosample/25649281
https://www.ncbi.nlm.nih.gov/biosample/25649282
https://www.ncbi.nlm.nih.gov/biosample/25649283
https://www.ncbi.nlm.nih.gov/biosample/25649284
https://www.ncbi.nlm.nih.gov/biosample/25649285
https://www.ncbi.nlm.nih.gov/biosample/25649286
https://www.ncbi.nlm.nih.gov/biosample/25649287
https://www.ncbi.nlm.nih.gov/biosample/25649288
https://www.ncbi.nlm.nih.gov/biosample/25649289
https://www.ncbi.nlm.nih.gov/biosample/25649290
https://www.ncbi.nlm.nih.gov/biosample/25649291
https://www.ncbi.nlm.nih.gov/biosample/25649292
https://www.ncbi.nlm.nih.gov/biosample/25649293
https://www.ncbi.nlm.nih.gov/biosample/25649294
https://www.ncbi.nlm.nih.gov/biosample/25649295
https://www.ncbi.nlm.nih.gov/biosample/25649296
https://www.ncbi.nlm.nih.gov/biosample/25649297
https://www.ncbi.nlm.nih.gov/biosample/25649298
https://www.ncbi.nlm.nih.gov/biosample/25649299
https://www.ncbi.nlm.nih.gov/biosample/25649300
https://www.ncbi.nlm.nih.gov/biosample/25649301
https://www.ncbi.nlm.nih.gov/biosample/25649302
https://www.ncbi.nlm.nih.gov/biosample/25649303
https://www.ncbi.nlm.nih.gov/biosample/25649304
https://www.ncbi.nlm.nih.gov/biosample/25649305
https://www.ncbi.nlm.nih.gov/biosample/25649306
https://www.ncbi.nlm.nih.gov/biosample/25649307

These reads will be released upon publication

## Appendix and FAQ

:::info
**Find this document incomplete?** Leave a comment!
:::

###### tags: `tools` `scripts'
