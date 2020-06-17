/****************************************************************** 
*No other files except the webshell.csv data, everything is in this code.

*Name: Huajie Xu
*Purpose: Final project
*Date:
*Description: This is the SAS version of analyzing the features of PHP webshell.
*After analyzing PHP webshells and normal PHP codes, we have the raw CSV data webshell.csv containing the following features: 

*Label: 1 for webshell, 0 for normal
*Length: The length of the code file
*Entropy: The entropy of the whole context
*Count_exec/zip/code/chr/re/other: Amount of sensitive functions
*maxlen: The length of the longest word

*The purpose of this program is to:
*1. Find the correlation between these features.
*2. Try to replace dimension by replacing features with PCAs
*3. Try to identify webshell using regression.

*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

**Import CSV**;
FILENAME REFFILE '/folders/myfolders/sasuser.v94/Raw_data/webshell.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV REPLACE
	OUT=work.webshell;
	GETNAMES=YES;
RUN;

**Univariate Analysis**;
title "Univariate Analysis"; 
proc univariate data=webshell;
   var LEN -- MAXLEN;
run;

*** Normalize the data ***;
proc standard DATA=webshell
              MEAN=0 STD=1 
              OUT=webshell_z;
   var LEN -- MAXLEN;
run;

**PCA Analysis**;
title "PCA Analysis";   
title2 "Corrolation between Variables"; 
proc corr data=webshell_z; 
   var LEN -- MAXLEN;
run;

** creat an output dataset with scores **;
title "PCA Analysis";   
title2 " Output Dataset"; 
proc princomp data=webshell_z  out=webshell_pca;
   var LEN -- MAXLEN;
run;

title "Regression";   
** Choose Prin1 to Prin6 as PCA and do the MAXR regression**;
** **;
proc reg data = webshell_pca outest=poi PLOTS(MAXPOINTS=NONE);
    model label = Prin1 -- Prin6
                /   dwProb STB selection=MAXR;
run;


** Try to predict label (1 for webshell 0 for normal) based on Prin1-Prin6 **;
proc logistic data=webshell_pca descending;
    model label= Prin1 -- Prin6; 
run; 