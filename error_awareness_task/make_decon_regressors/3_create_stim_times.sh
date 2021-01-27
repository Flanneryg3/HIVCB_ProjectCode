#!/bin/bash
# DESCRIPTION/USEAGE: Create motion censor file and calculate motion metrics, create behavioral stim_time_files. Calls python script make-EAT-refs.py
#                     July, 2016 M.Sutherland, M. Riedel
#                     -There should be no need to edit anything in this file. Edits (e.g., to subject #, SCRATCHpath should be done in the 1_create_AFNI_files.sub file
#                      which calls this script.

##########################################################################################
project='MSUT_HIV_CB'
paradigm='EAT'
sub=$1               #variable passed from .sub call
SCRATCHpath=$2       #variable passed from .sub call
SCRATHscriptDir=$3   #variable passed from .sub call
file_check_folder=$4 #variable passed from .sub call
##########################################################################################
echo "subject: ${sub}"
cd ${SCRATCHpath}/${project}/${paradigm}/${sub}/


### STEP-0:CLEAN UP FILES FROM ANY PREVIOUS RUN OF THIS SCRIPT ###
rm -f ${sub}-${paradigm}_enorm.1D ${sub}-${paradigm}_CENSORTR.txt ${sub}-${paradigm}_censor.1D \
${sub}-EAT_censor_?contTR.1D ${sub}-${paradigm}_motion_info.out ###### !!!!!!!!!! list event text files here !!!!!!!!! ########


### STEP-1: CENSOR FILE AND MOTION METRICS###
#Get total number of images
numTotalTR=$(3dinfo -nt ${sub}-${paradigm}-norm+tlrc) 
          echo "Total TRs: $numTotalTR"
#Get number images for each run, indicating when each run begins in the concatenated file is important for censoring first 3 TRs of each run
R1_TR=$(3dinfo -nt ${sub}-${paradigm}-1+orig)
R2_TR=$(3dinfo -nt ${sub}-${paradigm}-2+orig)
R3_TR=$(3dinfo -nt ${sub}-${paradigm}-3+orig)
R4_TR=$(3dinfo -nt ${sub}-${paradigm}-4+orig)
R5_TR=$(3dinfo -nt ${sub}-${paradigm}-5+orig)
R6_TR=$(3dinfo -nt ${sub}-${paradigm}-6+orig)
          echo "RUN1 TRs: ${R1_TR};     RUN2 TRs: ${R2_TR};     RUN3 TRs: ${R3_TR};     RUN4 TRs: ${R4_TR};     RUN5 TRs: ${R5_TR};     RUN6 TRs: ${R6_TR}" 
#Verify each run's TRs sum to the total TRs expected in the concatenated -norm+tlrc file
TR_sum_total=$((R1_TR + R2_TR + R3_TR + R4_TR + R5_TR + R6_TR))
if [ $numTotalTR != $TR_sum_total ]; then
	 echo "*****WARNING: TR_total and TR_sum from each run do not match" 
fi


#USE 1D_TOOL to create censor file AND then calculate motion metrics from output     #     -censor_next_TR \            
echo "...........creating censor file..........."
1d_tool.py -infile ${sub}-${paradigm}-motion.1D \
     -set_run_lengths $R1_TR $R2_TR $R3_TR $R4_TR $R5_TR $R6_TR\
     -censor_prev_TR \
     -show_censor_count \
     -show_max_displace \
     -censor_motion 0.35 ${sub}-${paradigm} > ${sub}-${paradigm}_motion_info.out \
     -censor_first_trs 5

#Calculate motion metrics
echo "...........calculating motion metrics..........."
Num_not_censored=(`1dsum ${sub}-${paradigm}_censor.1D`) # _censor.1D file is a list of 1's and 0's where 1 indicates TRs retained.
Num_censored=$((numTotalTR - Num_not_censored))
per_censored=`ccalc ${Num_censored}/${numTotalTR}*100`  #cclac AFNI program for mathematical operations with decimals
displacement_sum=(`1dsum ${sub}-${paradigm}_enorm.1D`) #enorm file: files showing how much TR displace from the one before it. Subtracts motion parameters from previous TR (6 motion parameters), squares the differences and sums them to get a singla value for each TR. 1dsum here adds all those values for each TR up.
displacement_mean=`ccalc ${displacement_sum} / ${numTotalTR}`  #dividing the summed motion by the number of TRs gives an estimate of average framewise displacement
echo "SUBJ: ${sub}     numTR: ${numTotalTR};     NOT CENSORED: ${Num_not_censored};     CENSORED: ${Num_censored};     %CENSORED: ${per_censored};     DSum: ${displacement_sum};       DMean: ${displacement_mean}"
echo "SUBJ: ${sub}     numTR: ${numTotalTR};     NOT CENSORED: ${Num_not_censored};     CENSORED: ${Num_censored};     %CENSORED: ${per_censored};     DSum: ${displacement_sum};       DMean: ${displacement_mean}" >> ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/all_sub_motion_summary.txt

#run python script to further censor small segments of un-censored TRs in-between censored sections (e.g., ...0100110001111111...change to ...0000000001111111...) (i.e., uncensored segments of data lasting fewer than x continguous volumes/TRs as a result of 1d_tool are censored here.
python ${SCRATCHpath}/${project}/${SCRATHscriptDir}/censor_non-contig_TRs.py ${sub}-EAT_censor.1D ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder} 3       #input in order: censor file, out_put folder, number of contiguous TRs desired



### STEP-2: STIM Time files ###
echo "...........creating stim time files..........."
python ${SCRATCHpath}/${project}/${SCRATHscriptDir}/make-EAT-refs.py ${sub}-EAT-eprime.txt EAT-group.txt


### STEP-3: COPY FILES and CLEAN UP FROM PREVIOUS STEPS
#no need/nothing to clean up at this point


###SEND OUT REMINDER INSTRUCTIONS TO THE SCREEN ###
echo "***NEXT STEP: QC of censor, stim time, and cat files. After QC,proceed to 4_EAT_blur.sub"

###--------------------------------------------------------------------------------------------------------------------------------------------

