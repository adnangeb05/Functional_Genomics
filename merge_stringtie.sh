##CODE B. Code for the STRINGTIE Merge: (default or standard parameters)
1.	#!/bin/sh  
2.	 
3.	#Goal  
4.	#merge the .gtf file using stringtie  
5.	 
6.	 
7.	#load the module  
8.	source /opt/asn/etc/asn-bash-profiles-special/modules.sh  
9.	module load stringtie/1.3.3  
10.	 
11.	#Define file paths  
12.	FILEDIR=/scratch/aubcls05/group  
13.	Anno="$FILEDIR/PA42.3.0.1.fasta.all.gff"  
14.	#The mergelist.txt file should have the path otherwise you need to keep all .gtf in same file  
15.	#mergelist.txt need to have detail path for all the .gtf  
16.	 
17.	#test file paths  
18.	#echo $Anno  
19.	 
20.	#Merge with stringties using all samples .gtf and annotation file (gtf/gff/gff3)  
21.	# Reference available if available -G ref.gtf/gff/gff3 need to see your gff is actually gff3 competable  
22.	#if you have only gff then convert it to gtf ot gff3  
23.	  
24.	  
25.	stringtie --merge -p 8 -G $Anno -o stringtie_merged_std.gtf /home/aubcls05/khan/code/group/mergelist_std.txt  
26.	exit  
27.	 
28.	#Need to run after mering the .gtf files using merged stringtie_merge_std_gtf.sh  
29.	#run only this part to create ballgown files  
30.	#stringtie -e -B -p 8 -G $MERGED -o ${TissueID}_ballgown.gtf ${TissueID}_sorted.bam  
31.	#exit  
