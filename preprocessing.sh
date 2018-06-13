#!/bin/bash -l
#$ -V
#$ -pe OpenMP 1
#$ -l h_rt=2:00:00,h_rss=2G
#$ -wd /mnt/projects/mslim/ITH/bin/sclust/output/bamprocess/
#$ -N bamprocess
#$ -j y
#$ -o stdout/

prefix="pp05"
nbam="/mnt/projects/mslim/ITH/bin/sclust/$prefix.normal.bam"
tbam="/mnt/projects/mslim/ITH/bin/sclust/$prefix.tumor.bam"
for i in {1..22} 'X'
    do
        qs -v -c 1 -w /mnt/projects/mslim/ITH/bin/sclust/output/bamprocess/ -m 2G -t 2:00:00 -n pre_chr$1 -b "Sclust bamprocess -t $tbam  -n $nbam -o $prefix -part 2 -build hg19 -r chr$i"
    done
