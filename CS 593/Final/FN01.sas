/****************************************************************** 
*Name: Huajie Xu
*Purpose: Final Exam Q1&Q2
*Date:
*Description: 
*
*I pledge my honor that I have abided by the Stevens Honor System.  
*******************************************************************/

libname sasdata "/folders/myfolders/sasuser.v94/SAS_data/";

*** Problem 1 ***;
proc copy in=sasdata out=work;
   select pca_data;
run;

*** Normalize the data ***;
proc standard DATA=pca_data
              MEAN=0 STD=1 
              OUT=pca_data_z;
   var X1 - X6;
run;

title "PCA Analysis";   
title2 "Corrolation between Variables"; 
proc corr data=pca_data_z; 
   var X1 - X6;
run;

title "PCA Analysis"; 
title2 "Univariate Analysis"; 
proc univariate data=pca_data_z;
   var X1 - X6;
run;
title " "; 
title2 " "; 

proc princomp data=pca_data_z  out=pca_data_pca;
   var X1 - X6;
run;

*** Delete X_ columns ***;
data pca_data_pca;
  set pca_data_pca (drop=X:);
run;

*** Problem 2 ***;

title "Stepwise Selection"; 
proc reg data = pca_data_pca;
    model Y = Prin1 Prin2 Prin3 Prin4 Prin5 Prin6
            /   dwProb STB selection=stepwise;
run;

title "maxR Selection"; 
proc reg data = pca_data_pca;
    model Y = Prin1 Prin2 Prin3 Prin4 Prin5 Prin6
            /   dwProb STB selection=MAXR;
run;