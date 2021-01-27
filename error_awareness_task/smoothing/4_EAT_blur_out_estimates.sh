#!/bin/bash
# DESCRIPTION/USEAGE: Blur dataset....
#                     october, 2016 M.Sutherland
#                     -There should be no need to edit anything in this file. Edits (e.g., to subject #, session, SCRATCHpath should be done in the .sub file
#                      which calls this script.

##########################################################################################
DICOMpath='/data/nbc/DICOM/NIDA/044/data'
project='MSUT_HIV_CB'
paradigm='EAT'
AFNIDIR='/home/applications/afni/abin/afni/'
SCRATCHpath=$1       #variable passed from .sub call
SCRATHscriptDir=$2   #variable passed from .sub call
file_check_folder=$3 #variable passed from .sub call

##########################################################################################

### STEP-6: Combine all estimates of blur into single files for easy visual inspection###
echo "...........Catenate blur estimate outputs..........." 

echo ".........................PRE........................" 
cd ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/preBlur_est/

cat FWHM-norm-*.txt > All-FWHM-norm.txt
sed -n '1~2!p' All-FWHM-norm.txt > All-FWHM-norm-acf.txt
	#a=$(1dsum All-FWHM-norm.txt)      #add up all values in the file (x y z rows)
	a=$(1dsum All-FWHM-norm-acf.txt)
	read -a b <<< $a                  #convert the a vaiable to an array variable designated b
	#num=$(wc -l < All-FWHM-norm.txt)  #find the number of values that contributed to the sum
	num=$(wc -l < All-FWHM-norm-acf.txt)
		FWHMx_avg=$(ccalc ${b[0]}/${num}) #from sum and n calculate mean value
		FWHMy_avg=$(ccalc ${b[1]}/${num})
		FWHMz_avg=$(ccalc ${b[2]}/${num})
	echo "AVERAGE PRE-BLUR estimate(x,y,z):" $FWHMx_avg $FWHMy_avg $FWHMz_avg
	#echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm.txt      #output average blur estimates to file for easy viewing
	echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm-acf.txt

echo ".........................POST......................." 
cd ${SCRATCHpath}/${project}/${paradigm}/${file_check_folder}/postBlur_est/

cat FWHM-norm7-*.txt > All-FWHM-norm7.txt
sed -n '1~2!p' All-FWHM-norm7.txt > All-FWHM-norm7-acf.txt
	#a=$(1dsum All-FWHM-norm7.txt)      #add up all values in the file (x y z rows)
	a=$(1dsum All-FWHM-norm7-acf.txt)
	read -a b <<< $a                   #convert the a vaiable to an array variable designated b
	#num=$(wc -l < All-FWHM-norm7.txt)  #find the number of values that contributed to the sum
	num=$(wc -l < All-FWHM-norm7-acf.txt)
		FWHMx_avg=$(ccalc ${b[0]}/${num}) #from sum and n calculate mean value
		FWHMy_avg=$(ccalc ${b[1]}/${num})
		FWHMz_avg=$(ccalc ${b[2]}/${num})
	echo "AVERAGE POST-BLUR[7] estimate(x,y,z):" $FWHMx_avg $FWHMy_avg $FWHMz_avg
	#echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm7.txt      #output average blur estimates to file for easy viewing
	echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm7-acf.txt

cat FWHM-norm8-*.txt > All-FWHM-norm8.txt
sed -n '1~2!p' All-FWHM-norm8.txt > All-FWHM-norm8-acf.txt
	#a=$(1dsum All-FWHM-norm8.txt)      #add up all values in the file (x y z rows)
	a=$(1dsum All-FWHM-norm8-acf.txt)
	read -a b <<< $a                   #convert the a vaiable to an array variable designated b
	#num=$(wc -l < All-FWHM-norm8.txt)  #find the number of values that contributed to the sum
	num=$(wc -l < All-FWHM-norm8-acf.txt)
		FWHMx_avg=$(ccalc ${b[0]}/${num}) #from sum and n calculate mean value
		FWHMy_avg=$(ccalc ${b[1]}/${num})
		FWHMz_avg=$(ccalc ${b[2]}/${num})
	echo "AVERAGE POST-BLUR[8] estimate(x,y,z):" $FWHMx_avg $FWHMy_avg $FWHMz_avg
	#echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm8.txt      #output average blur estimates to file for easy viewing
	echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm8-acf.txt

cat FWHM-norm9-*.txt > All-FWHM-norm9.txt
sed -n '1~2!p' All-FWHM-norm9.txt > All-FWHM-norm9-acf.txt
	#a=$(1dsum All-FWHM-norm9.txt)      #add up all values in the file (x y z rows)
	a=$(1dsum All-FWHM-norm9-acf.txt)
	read -a b <<< $a                   #convert the a vaiable to an array variable designated b
	#num=$(wc -l < All-FWHM-norm9.txt)  #find the number of values that contributed to the sum
	num=$(wc -l < All-FWHM-norm9-acf.txt)
		FWHMx_avg=$(ccalc ${b[0]}/${num}) #from sum and n calculate mean value
		FWHMy_avg=$(ccalc ${b[1]}/${num})
		FWHMz_avg=$(ccalc ${b[2]}/${num})
	echo "AVERAGE POST-BLUR[9] estimate(x,y,z):" $FWHMx_avg $FWHMy_avg $FWHMz_avg
	#echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm9.txt      #output average blur estimates to file for easy viewing
	echo $FWHMx_avg $FWHMy_avg $FWHMz_avg > All-AVG-norm9-acf.txt


	     
  



