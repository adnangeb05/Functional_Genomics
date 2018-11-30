# Functional_Genomics

# CODE A. Code for the HISAT2 Alignment, STRINGTIE, and generate BALLGOWN compatible output files: (default or standard parameters) 

1.	#!/bin/sh    
2.	   
3.	#Goals:
4.	#Alignment with HISAT2
5.	#Get the counts and stats using samtools 
6.	#use transcript assembler STRINGTIE to get BALLGOWN compatible files 
7.	
8.	#load the module    
9.	source /opt/asn/etc/asn-bash-profiles-special/modules.sh    
10.	module load hisat2/2.0.5    
11.	module load samtools/1.2    
12.	module load stringtie/1.3.3    
13.	   
14.	## Define the tissue ID    
15.	TissueID="C2"    
16.	   
17.	# Make a directory in Scratch    
18.	OUTDIR=/scratch/aubcls05/group/${TissueID}_std    
19.	#mkdir $OUTDIR    
20.	cd $OUTDIR    
21.	   
22.	#Define path variables    
23.	FILEDIR=/scratch/aubcls05/group    
24.	REF="$FILEDIR/Daphnia_pulex_PA42_v3.0_tran"    
25.	Anno="$FILEDIR/PA42.3.0.1.fasta.all.gff"    
26.	R1="$FILEDIR/${TissueID}*_R1_*.fastq"    
27.	R2="$FILEDIR/${TissueID}*_R2_*.fastq"    
28.	MERGED="/home/aubcls05/khan/code/group/stringtie_merged_std.gtf"    
29.	   
30.	#Test the file paths    
31.	#echo $Anno $REF $R1 $R2 $MERGED    
32.	   
33.	#Need to run after mering the .gtf files using merged stringtie_merge_std_gtf.sh    
34.	#run only this part to create ballgown files    
35.	#stringtie -e -B -p 8 -G $MERGED -o ${TissueID}_ballgown.gtf ${TissueID}_sorted.bam    
36.	#exit    
37.	   
38.	#Build or indexing the Reference geneome for hisat2 #make once then use for all      
39.	#cd /scratch/aubcls05/group    
40.	#hisat2-build Daphnia_pulex_PA42_v3.0.fasta Daphnia_pulex_PA42_v3.0_tran    
41.	   
42.	#Run the hisat2 with default parameters for pair end data    
43.	    
44.	hisat2 -p 8 --dta -x $REF -1 $R1 -2 $R2 -S ${TissueID}.sam    
45.	   
46.	#Convert sam to bam using samtools     
47.	     
48.	samtools view -bS ${TissueID}.sam > ${TissueID}_unsorted.bam    
49.	   
50.	#Sorted output of the bam file     
51.	    
52.	samtools sort -@ 8 ${TissueID}_unsorted.bam -o ${TissueID}_sorted.bam    
53.	   
54.	# index the sorted bam file     
55.	    
56.	samtools index ${TissueID}_sorted.bam    
57.	   
58.	# counts of reads mapped to each transcript; and calcuate the stats.    
59.	samtools idxstats ${TissueID}_sorted.bam > ${TissueID}_Counts.txt    
60.	samtools flagstat ${TissueID}_sorted.bam > ${TissueID}_Stats.txt    
61.	   
62.	# Reference available if available -G ref.gtf/gff/gff3     
63.	#need to see your gff is actually gff3 competable      
64.	#if you have only gff then convert it to gtf ot gff3     
65.	    
66.	stringtie -p 8 -G $Anno -o ${TissueID}.gtf ${TissueID}_sorted.bam    
67.	    
68.	    
69.	exit    
70.	   
71.	#go to top and run only this part to create ballgown files after having the merged .gtf file      
72.	#Need to run after mering the .gtf files using merged stringtie_merge_std_gtf.sh    
73.	#run only this part to create ballgown files    
74.	   
75.	#stringtie -e -B -p 8 -G $MERGED -o ${TissueID}_ballgown.gtf ${TissueID}_sorted.bam    
76.	#exit  
