#!/bin/bash
set -euo pipefail

while read id bam_location
do
    samtools view -H $bam_location/normal/normal.bwamem.dedup.realn.recal.bam | sed -Ee 's/SN:([0-9XY])/SN:chr\1/' -e 's/SN:chrM/SN:chrM/' | samtools reheader - $bam_location/normal/normal.bwamem.dedup.realn.recal.bam > $id.normal.bam
    samtools view -H $bam_location/tumor/tumor.bwamem.dedup.realn.recal.bam | sed -Ee 's/SN:([0-9XY])/SN:chr\1/' -e 's/SN:chrM/SN:chrM/' | samtools reheader - $bam_location/tumor/tumor.bwamem.dedup.realn.recal.bam > $id.tumor.bam
    /mnt/projects/mslim/ITH/bin/sclust/vcf_parser.py $bam_location/variants/mutect.PASS.vcf.gz $id.mutations.vcf
done < samples.txt

for bams in `ls *.bam`
do
    samtools index $bams > $bams.bai
done

#for header in `ls | grep header`
#do
#    sed -i -Ee 's/SN:([0-9XY])/SN:chr\1/' -e 's/SN:chrM/SN:chrM/' $header
#done
