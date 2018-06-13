#!/usr/bin/env python3

import pandas as pd
import sys


vcf_tables = pd.read_table(sys.argv[1],sep='\t',header=105)
print(vcf_tables.columns)

vcf_tables['GT'], \
    vcf_tables['AD'], \
    vcf_tables['BQ'], \
    vcf_tables['DP'], \
    vcf_tables['AF'], \
    vcf_tables['SS'] = zip(*vcf_tables['tumor'].map(lambda x: x.split(':')))

vcf_tables['GT_N'], \
    vcf_tables['AD_N'], \
    vcf_tables['BQ_N'], \
    vcf_tables['DP_N'], \
    vcf_tables['AF_N'], \
    vcf_tables['SS_N'] = zip(*vcf_tables['normal'].map(lambda x: x.split(':')))

#formatting output for writeout

vcf_tables['DP'] = vcf_tables['DP'].apply(lambda x: 'DP='+ str(x))
vcf_tables['DP_N'] = vcf_tables['DP_N'].apply(lambda x: 'DP_N='+str(x))
vcf_tables['AF'] = vcf_tables['AF'].apply(lambda x: 'AF='+x)
vcf_tables['AF_N'] = vcf_tables['AF_N'].apply(lambda x: 'AF_N='+x)
vcf_tables['FR'] = '.'
vcf_tables['TG'] = '.'
vcf_tables['INFO'] = vcf_tables[['DP','DP_N','AF','AF_N','FR','TG']].apply(lambda x: ';'.join(x), axis=1)

def ammend(val):
    if val != 'MT':
        return 'chr'+val
    else:
        return 'chr'+M

vcf_tables['#CHROM'] = vcf_tables['#CHROM'].apply(lambda x: ammend(x))

out_tables = vcf_tables[['#CHROM','POS','ID','REF','ALT','QUAL','FILTER','INFO']]

out_vcf = open(sys.argv[2],'w')
out_vcf.write('##INFO=<ID=DP,Number=1,Type=Integer,Description="Read Depth Tumor"> \n\
##INFO=<ID=DP_N,Number=1,Type=Integer,Description="Read Depth Normal"> \n\
##INFO=<ID=AF,Number=A,Type=Float,Description="Allelic Frequency Tumor"> \n\
##INFO=<ID=AF_N,Number=A,Type=Float,Description="Allelic Frequency Normal"> \n\
##INFO=<ID=FR,Number=1,Type=Float,Description="Forward-Reverse Score"> \n\
##INFO=<ID=TG,Number=1,Type=String,Description="Target Name (Genome Partition)"> \n\
##INFO=<ID=DB,Number=0,Type=Flag,Description="dbSNP Membership">\n')

out_tables.to_csv(out_vcf, sep='\t',index=False)


