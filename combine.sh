#!/bin/bash -l
#$ -V
#$ -pe OpenMP 1
#$ -l h_rt=2:00:00,h_rss=2G
#$ -wd /mnt/projects/mslim/ITH/bin/sclust/
#$ -N sclust
#$ -o stdout/ -e stdout/
#$ -cwd

#nbam="/mnt/projects/mslim/ITH/bin/sclust/hg_19.normal.bam"
#tbam="/mnt/projects/mslim/ITH/bin/sclust/hg_19.tumor.bam"
#for i in {1..22} 'X'
#    do
#        qs -v -c 1 -w /mnt/projects/mslim/ITH/bin/sclust/ -m 2G -t 2:00:00 -n pre_chr$1 -b "Sclust bamprocess -t $tbam  -n $nbam -o test -part 2 -build hg19 -r chr$i"
#    done
mkdir -p output
cd output/bamprocess/
prefix=pp05
Sclust bamprocess -i $prefix -o $prefix
